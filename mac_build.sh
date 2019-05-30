#!/usr/bin/env bash

cd SEAL
./configure --prefix=$1
export PYTHONPATH=$PYTHONPATH:$1
make
cd ../SEALPython
pip install --upgrade pip
pip install setuptools
pip install -r requirements.txt
git clone https://github.com/pybind/pybind11.git
cd pybind11
git checkout a303c6fc479662fd53eaa8990dbc65b7de9b7deb
cd ..
CFLAGS='-stdlib=libc++' python setup.py build_ext -i -I $1/include/seal -O $1/lib/SEAL/libseal.a
export PYTHONPATH=$PYTHONPATH:$(pwd):$(pwd)/../bin
