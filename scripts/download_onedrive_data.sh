#!/bin/bash
#Must have lua5.3 installed
set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DOWNLOAD_DIR=$(realpath "$1")

cd $DOWNLOAD_DIR
git clone https://gitlab.com/VADemon/onedeath.git
cd onedeath
lua main.lua 'https://1drv.ms/f/s!AjSouo0_uGDBhMJ_x2uiiHxS08T4jQ'
mv Navi-20_af2_databases/* $DOWNLOAD_DIR
cd $DOWNLOAD_DIR
rm -rf onedeath

cd $SCRIPT_DIR
./download_pdb_mmcif.sh $DOWNLOAD_DIR