#!/bin/bash
NVARCH=x86_64
NV_CUDA_CUDART_VERSION=11.1.74-1
NV_CUDA_COMPAT_PACKAGE=cuda-compat-11-1
NV_CUDA_LIB_VERSION=11.1.1-1
NV_NVTX_VERSION=11.1.74-1
NV_LIBNPP_PACKAGE=libnpp-11-1=11.1.2.301-1
NV_LIBCUSPARSE_VERSION=11.3.0.10-1
NV_LIBCUBLAS_PACKAGE_NAME=libcublas-11-1
NV_LIBCUBLAS_PACKAGE=libcublas-11-1=11.3.0.106-1
NV_LIBNCCL_PACKAGE_NAME=libnccl2
NV_LIBNCCL_PACKAGE=libnccl2=2.8.4-1+cuda11.1
NV_CUDNN_PACKAGE_NAME=libcudnn8
NV_CUDNN_PACKAGE=libcudnn8=8.0.5.39-1+cuda11.1

apt-get update
apt-get install -y --no-install-recommends gnupg2 curl ca-certificates
curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/$NVARCH/3bf863cc.pub | apt-key add -
echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/$NVARCH /" > /etc/apt/sources.list.d/cuda.list

apt-get update
apt-get install -y --no-install-recommends cuda-cudart-11-1=$NV_CUDA_CUDART_VERSION $NV_CUDA_COMPAT_PACKAGE
ln -s cuda-11.1 /usr/local/cuda
echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf
echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf # buildkit

#add to .bashrc
export PATH=$PATH:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

apt-get update
apt-get install -y --no-install-recommends cuda-libraries-11-1=$NV_CUDA_LIB_VERSION $NV_LIBNPP_PACKAGE cuda-nvtx-11-1=$NV_NVTX_VERSION libcusparse-11-1=$NV_LIBCUSPARSE_VERSION $NV_LIBCUBLAS_PACKAGE $NV_LIBNCCL_PACKAGE
apt-mark hold $NV_LIBCUBLAS_PACKAGE_NAME $NV_LIBNCCL_PACKAGE_NAME # buildkit

apt-get update
apt-get install -y --no-install-recommends $NV_CUDNN_PACKAGE
apt-mark hold $NV_CUDNN_PACKAGE_NAME