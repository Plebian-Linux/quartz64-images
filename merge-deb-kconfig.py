#!/usr/bin/env python3
import argparse
import re
from os import path
from sys import stdout, stderr


KCONFIG_REGEX = re.compile(r"^(?P<kc_name>[\w]+)=(?P<kc_value>.+)$")


def output_config_file(conf, f):
    for key, value in conf.items():
        f.write("{0}={1}\n".format(key, value))


def parse_kconfig_file(cf):
    out = {}
    with open(cf, 'r') as f:
        for line in f:
            l_s = line.strip()
            if l_s and not l_s.startswith('#'):
                m = re.match(KCONFIG_REGEX, l_s)
                if not m:
                    raise Exception("Found invalid config string '{0}'"
                                    .format(l_s))
                out[m.group("kc_name").upper()] = m.group("kc_value")

    return out


def parse_overrides(overrides):
    p_ovr = {}
    for o in overrides:
        m = re.fullmatch(KCONFIG_REGEX, o)
        if m:
            p_ovr[m.group("kc_name").upper()] = m.group("kc_value")
        else:
            raise Exception("KEY=VALUE please!")

    return p_ovr


def merge_configs(conf1, conf2):
    out = conf1.copy()
    out.update(conf2)
    return out


def merge_files(config_files, overrides, output_file):
    config_values = {}
    for cf in config_files:
        config_values = merge_configs(config_values, parse_kconfig_file(cf))

    config_values = merge_configs(config_values, overrides)
    output_config_file(config_values, output_file)
    output_file.close()


def main():
    parser = argparse.ArgumentParser(
        description="Merges the Debian Kernel team's KConfig files into one "
                    "config file, but I wrote it")
    parser.add_argument("-a", "--arch", required=True,
                        help="Name of the arch subdirectory you're generating "
                             "a config for")
    parser.add_argument("-f", "--output", type=argparse.FileType('w'),
                        help="Destination of the processed output file")
    parser.add_argument("-o", "--override", action="append",
                        help="KEY=VALUE of overrides you wish to perform")
    parser.add_argument("directory", help="Debian directory of configs")
    args = parser.parse_args()

    p_o = parse_overrides(args.override or [])
    config_files = [path.join(args.directory, "config"),
                    path.join(args.directory, args.arch, "config")]

    output = args.output or stdout
    merge_files(config_files, p_o, output)


if __name__ == "__main__":
    main()
