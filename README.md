<div align=center>
<img src="./docs/parafoldlogo.png" width="400" >
</div>

# ParaFold

Author: Bozitao Zhong - zbztzhz@gmail.com

:bookmark_tabs: Please cite our [paper](https://arxiv.org/abs/2111.06340) if you used ParaFold (ParallelFold) in you research. 

## Overview

Recent change: **ParaFold now supports AlphaFold 2.3.1**

This project is a modified version of DeepMind's [AlphaFold2](https://github.com/deepmind/alphafold) to achieve high-throughput protein structure prediction. 

We have these following modifications to the original AlphaFold pipeline:

- Divide **CPU part** (MSA and template searching) and **GPU part** (prediction model)



## How to install 

We recommend to install AlphaFold locally, and not using **docker**. An install script for ubuntu 20.04 is provided. Make sure to add ENV PATHs to your bashrc.

```bash
# clone this repo
git clone https://github.com/ivanpmartell/ParallelFold.git

# move to the scripts directory
cd ParallelFold/scripts

# run installation scripts
chmod +x local_install_nvidia.sh
sudo ./local_install_nvidia.sh
echo 'export PATH=$PATH:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' >> ~/.bashrc

chmod +x local_install.sh
sudo ./local_install.sh
/opt/conda/bin/conda init

# make script executable
chmod +x run_alphafold.sh
```



## Some detail information of modified files

- `run_alphafold.py`: modified version of original `run_alphafold.py`, it has multiple additional functions like skipping featuring steps when exists `feature.pkl` in output folder
- `run_alphafold.sh`: bash script to run `run_alphafold.py`
- `run_figure.py`: this file can help you make figure for your system



## How to run

Visit the [usage page](./docs/usage.md) to know how to run



## What is this for

ParallelFold can help you accelerate AlphaFold when you want to predict multiple sequences. After dividing the CPU part and GPU part, users can finish feature step by multiple processors. Using ParaFold, you can run AlphaFold 2~3 times faster than DeepMind's procedure. 

**If you have any question, please raise issues**







