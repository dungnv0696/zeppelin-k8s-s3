#!/bin/bash

# Your repo name
repo=vmlp
# Zeppelin version
version=0.10.1
git_commit="fd74504"
# Spark version compatible to the Zeppelin version
spark_version=3.5
# Hadoop major version
hadoop_version=3
# Hadoop minor version
hadoop_minor_version=3.4
# AWS SDK version compatible to the Hadoop version
aws_sdk_version=1.12.262

cd zeppelin-distribution-source
docker build --build-arg version=$version --build-arg commit=$git_commit -t ${repo}/zeppelin-distribution:${version} .
cd ..
cd zeppelin-server
docker build --build-arg version=$version --build-arg REPO=$repo -t ${repo}/zeppelin-server:${version} .
cd ..
cd zeppelin-interpreter
docker build --build-arg version=$version --build-arg REPO=$repo -t ${repo}/zeppelin-interpreter:${version} .
cd ..
cd spark
docker build --build-arg version=$version --build-arg SPARK_VERSION=$spark_version \
 --build-arg HADOOP_VERSION=$hadoop_version --build-arg HADOOP_VERSION_MINOR=$hadoop_minor_version \
 --build-arg AWS_SDK_VERSION=$aws_sdk_version --build-arg REPO=$repo \
 -t ${repo}/spark:${version} .
