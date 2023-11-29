#!/bin/bash

# Your repo name
repo=dungnv0696
# Zeppelin version
version=0.10.1

# Spark version compatible to the Zeppelin version
spark_version=3.2.4
# Hadoop major version
hadoop_version=3.2
# Hadoop minor version
aws_hadoop_version=3.3.1
# AWS SDK version compatible to the Hadoop version
aws_sdk_version=1.11.901

cd zeppelin-distribution-binary
docker build --build-arg version=$version -t ${repo}/zeppelin-distribution:${version} .
cd ..
cd zeppelin-server
docker build --build-arg version=$version --build-arg REPO=$repo -t ${repo}/zeppelin-server:${version} .
cd ..
cd zeppelin-interpreter
docker build --build-arg version=$version --build-arg REPO=$repo -t ${repo}/zeppelin-interpreter:${version} .
cd ..
cd spark
docker build --build-arg version=$version --build-arg SPARK_VERSION=$spark_version \
 --build-arg HADOOP_VERSION=$hadoop_version --build-arg AWS_HADOOP_VERSION=$aws_hadoop_version \
 --build-arg AWS_SDK_VERSION=$aws_sdk_version --build-arg REPO=$repo \
 -t ${repo}/spark:${version} .

docker login

docker tag ${repo}/zeppelin-interpreter:${version} ${repo}/zeppelin-interpreter:python3.9-1.0
docker tag ${repo}/spark:${version} ${repo}/spark-interpreter:python3.9-spark${spark_version}-hadoop${hadoop_version}-1.0

docker push ${repo}/zeppelin-server:${version}
docker push ${repo}/zeppelin-interpreter:python3.9-1.0
docker push ${repo}/spark-interpreter:python3.9-spark${spark_version}-hadoop${hadoop_version}-1.0