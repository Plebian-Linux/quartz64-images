#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
    echo "Usage: $0 DIRECTORY"
    exit 1
fi

for f in $(find "$1" -iname '*.img.xz'); do
    echo "Processing ${f}"
    s_dir="${PWD}"
    f_dir="$(dirname "${f}")"
    f_name="$(basename "${f}")"
    echo "Entering ${f_dir}" && cd "${f_dir}"
    echo "Writing ${f_name}.sha256"
    sha256sum -b --tag "${f_name}" > "${f_name}.sha256"
    echo "Returning to ${s_dir}" && cd "${s_dir}"
done

exit 0
