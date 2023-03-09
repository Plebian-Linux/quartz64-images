#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
    echo "Usage: $0 DIRECTORY"
    exit 1
fi

find "$1" -iname '*.img.xz' -exec bash -c '
    echo "Processing" {}
    s_dir="${PWD}"
    f_dir="$(dirname "{}")"
    f_name="$(basename "{}")"
    echo "Entering ${f_dir}" && cd "${f_dir}"
    echo "Writing ${f_name}.sha256"
    sha256sum -b --tag "${f_name}" > "${f_name}.sha256"
    echo "Returning to ${s_dir}" && cd "${s_dir}"' \;

exit 0
