#!/bin/bash

export my_dir=$(pwd)

echo "Loading configuration..."
source "${my_dir}"/config.sh

fi

# Email for git
git config --global user.email "${GITHUB_EMAIL}"
git config --global user.name "${GITHUB_USER}"

cd ~

if [ ! -d "${ROM_DIR}" ]; then
mkdir "${ROM_DIR}"
fi
cd "${ROM_DIR}"
if [ -d "${ROM_DIR}/out" ]; then
make clean -j$(nproc --all)
make clobber -j$(nproc --all)
fi

if [ ! -d "${ROM_DIR}/.repo" ]; then
echo "Initializing repository..."
repo init -u "${manifest_url}" -b "${branch}" --depth 1
fi
source "${my_dir}"/sync.sh
