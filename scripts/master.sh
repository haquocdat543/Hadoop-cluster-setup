#!/bin/bash

hostnamectl set-hostname Hadoop-Master
export HADOOP_VER="3.3.6"
yum install java -y
wget http://apache.cs.utah.edu/hadoop/common/current/hadoop-${HADOOP_VER}.tar.gz
tar -xvzf hadoop-${HADOOP_VER}.tar.gz
mv -f hadoop-${HADOOP_VER} hadoop
rm -f hadoop-${HADOOP_VER}.tar.gz
