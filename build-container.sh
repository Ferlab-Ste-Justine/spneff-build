#!/bin/bash

#Based on (with some adjustments to make it work): https://pcingola.github.io/SnpEff/download/#getting-the-source

apt-get update && apt-get install -y zip

cd /opt

git clone https://github.com/pcingola/SnpEff.git

git clone https://github.com/pcingola/SnpSift.git

cd SnpEff/lib

mvn install:install-file \
    -Dfile=antlr-4.5.1-complete.jar \
    -DgroupId=org.antlr \
    -DartifactId=antlr \
    -Dversion=4.5.1 \
    -Dpackaging=jar

mvn install:install-file \
    -Dfile=biojava3-core-3.0.7.jar \
    -DgroupId=org.biojava \
    -DartifactId=biojava3-core \
    -Dversion=3.0.7 \
    -Dpackaging=jar

mvn install:install-file \
    -Dfile=biojava3-structure-3.0.7.jar \
    -DgroupId=org.biojava \
    -DartifactId=biojava3-structure \
    -Dversion=3.0.7 \
    -Dpackaging=jar

mkdir /root/workspace
ln -s /opt/SnpEff /root/workspace/SnpEff
ln -s /opt/SnpSift /root/workspace/SnpSift
ln -s /opt/SnpEff /root/snpEff

cd /opt/SnpEff
./scripts_build/make.sh

mkdir -p /opt/host/build/snpEff
cp /opt/SnpEff/snpEff.jar /opt/host/build/snpEff/
cp /opt/SnpEff/SnpSift.jar /opt/host/build/snpEff/
cp /opt/SnpEff/snpEff.config /opt/host/build/snpEff/
cp /opt/SnpEff/LICENSE.md /opt/host/build/snpEff/
cp -r /opt/SnpEff/scripts /opt/host/build/snpEff/
cp -r /opt/SnpEff/galaxy /opt/host/build/snpEff/
cp -r /opt/SnpEff/exec /opt/host/build/snpEff/
cp -r /opt/SnpEff/examples /opt/host/build/snpEff/

cd  /opt/host/build
zip -r  snpEff.zip snpEff
rm -r /opt/host/build/snpEff