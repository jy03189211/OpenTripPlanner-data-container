#!/bin/bash
# this script is run inside the otp-data-tools container
set +e
apt-get update && \
  apt-get -y install \
    git build-essential python-dev protobuf-compiler libprotobuf-dev \
    make swig g++ python-dev libreadosm-dev \
    libboost-graph-dev libproj-dev libgoogle-perftools-dev \
    osmctools unzip zip python-pyproj wget python-argh

rm -rf /var/lib/apt/lists/*

wget https://bootstrap.pypa.io/get-pip.py && \
  python get-pip.py && \
  pip install imposm.parser && \
  pip install argh

mkdir -p one-busaway-gtfs-transformer && \
  wget -O one-busaway-gtfs-transformer/onebusaway-gtfs-transformer-cli.jar "http://nexus.onebusaway.org/service/local/artifact/maven/content?r=public&g=org.onebusaway&a=onebusaway-gtfs-transformer-cli&v=1.3.4-SNAPSHOT"

git clone https://github.com/jswhit/pyproj.git
cd pyproj
git checkout ec9151e8c6909f7fac72bb2eab927ff18fa4cf1d
python setup.py build
python setup.py install
cd ..

git clone --recursive -b fastmapmatch https://github.com/HSLdevcom/gtfs_shape_mapfit.git
cd gtfs_shape_mapfit
make -C pymapmatch
