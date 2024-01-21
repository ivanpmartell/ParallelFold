#!/bin/bash
#Must have python 3 installed
set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DOWNLOAD_DIR=$(realpath "$1")

cd $DOWNLOAD_DIR
git clone https://github.com/PrivacyDevel/OneDrive-MassDL-Cli.git
cd OneDrive-MassDL-Cli
mkdir downloads
python3 down 'URL_HERE'
mv downloads/* $DOWNLOAD_DIR
cd $DOWNLOAD_DIR
rm -rf OneDrive-MassDL-Cli

cd $SCRIPT_DIR
./download_pdb_mmcif.sh $DOWNLOAD_DIR