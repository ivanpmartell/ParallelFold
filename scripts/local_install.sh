#!/bin/bash
CUDA_VERSION=11.1.1
LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64

git clone https://github.com/google-deepmind/alphafold.git

apt-get update
apt-get install --no-install-recommends -y \
        build-essential \
        cmake \
        cuda-command-line-tools-$(cut -f1,2 -d- <<< ${CUDA_VERSION//./-}) \
        git \
        hmmer \
        kalign \
        tzdata \
        wget

git clone --branch v3.3.0 https://github.com/soedinglab/hh-suite.git /tmp/hh-suite
mkdir /tmp/hh-suite/build
pushd /tmp/hh-suite/build
cmake -DCMAKE_INSTALL_PREFIX=/opt/hhsuite ..
make -j 4 && make install
ln -s /opt/hhsuite/bin/* /usr/bin
popd
rm -rf /tmp/hh-suite

wget -q -P /tmp https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda
rm /tmp/Miniconda3-latest-Linux-x86_64.sh

#add this to .bashrc too
export PATH="/opt/conda/bin:$PATH"
export LD_LIBRARY_PATH="/opt/conda/lib:$LD_LIBRARY_PATH"

conda install -qy conda==23.5.2
conda install -y -c conda-forge \
      openmm=7.7.0 \
      cudatoolkit==$CUDA_VERSION \
      pdbfixer \
      pip \
      python=3.10
conda clean --all --force-pkgs-dirs --yes

mkdir /app
mv alphafold /app/

wget -q -P /app/alphafold/alphafold/common/ \
  https://git.scicore.unibas.ch/schwede/openstructure/-/raw/7102c63615b64735c4941278d92b554ec94415f8/modules/mol/alg/src/stereo_chemical_props.txt

pip3 install --upgrade pip --no-cache-dir
pip3 install -r /app/alphafold/requirements.txt --no-cache-dir
pip3 install --upgrade --no-cache-dir \
      jax==0.3.25 \
      jaxlib==0.3.25+cuda11.cudnn805 \
      -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html

chmod u+s /sbin/ldconfig.real

echo $'#!/bin/bash\n\
ldconfig\n\
python /app/alphafold/run_alphafold.py "$@"' > /app/run_alphafold.sh
chmod +x /app/run_alphafold.sh
