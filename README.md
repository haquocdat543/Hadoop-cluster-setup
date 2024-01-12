# Hadoop-cluster-setup
This is a demonstration of using Terraform to setup Hadoop cluster
## 1. Setup hosts
```
sudo su -
vi /etc/hosts
G
o
35.74.151.181 hadoop1
52.68.15.189 hadoop2
43.207.243.198 hadoop3
54.92.25.9 hadoop4
```

## 2. Environment
```
# Set hadoop environment variables
export HADOOP_HOME=$HOME/hadoop
export HADOOP_CONF_DIR=$HOME/hadoop/etc/hadoop
export HADOOP_MAPRED_HOME=$HOME/hadoop
export HADOOP_COMMON_HOME=$HOME/hadoop
export HADOOP_HDFS_HOME=$HOME/hadoop
export YARN_HOME=$HOME/hadoop
export PATH=$PATH:$HOME/hadoop/bin

# Set Java environment variables
export JAVA_HOME=$HOME/jre-opensdk
export PATH=$HOME/jre-opensdk/bin:$PATH
```

## 3. Files
`~/hadoop/etc/hadoop/hdfs-site.xml`
```
<configuration>
    <property>
        <name>fs.default.name</name>
        <value>hdfs://hadoop1:9000</value>
    </property>
</configuration>
```
`~/hadoop/etc/hadoop/hdfs-site.xml`
```
<configuration>
    <property>
            <name>dfs.namenode.name.dir</name>
            <value>/home/hadoop/data/nameNode</value>
    </property>

    <property>
            <name>dfs.datanode.data.dir</name>
            <value>/home/hadoop/data/dataNode</value>
    </property>

    <property>
            <name>dfs.replication</name>
            <value>1</value>
    </property>
</configuration>
```
`~/hadoop/etc/hadoop/yarn-site.xml`
```
<property>
        <name>yarn.nodemanager.resource.memory-mb</name>
        <value>1536</value>
</property>

<property>
        <name>yarn.scheduler.maximum-allocation-mb</name>
        <value>1536</value>
</property>

<property>
        <name>yarn.scheduler.minimum-allocation-mb</name>
        <value>128</value>
</property>

<property>
        <name>yarn.nodemanager.vmem-check-enabled</name>
        <value>false</value>
</property>
<property>
        <name>yarn.resourcemanager.hostname</name>
        <value>hadoop1</value>
</property>
```
`~/hadoop/etc/hadoop/mapred-site.xml`
```
<configuration>
    <property>
        <name>yarn.app.mapreduce.am.resource.mb</name>
        <value>512</value>
    </property>
    <property>
        <name>mapreduce.map.memory.mb</name>
        <value>256</value>
    </property>
    <property>
        <name>mapreduce.reduce.memory.mb</name>
        <value>256</value>
    </property>
   <property> 
      <name>mapreduce.jobtracker.address</name> 
      <value>hadoop1:9001</value> 
   </property> 
</configuration>
```
## 4. Copy files
```
cp ~/hadoop/etc/hadoop/mapred-site.xml.template ~/hadoop/etc/hadoop/mapred-site.xml
```
## 5. On Master
```
hdfs namenode -format
```
```
cd $HADOOP_HOME
./sbin/start-all.sh
```
## 6. Check daemon Master
```
jps
```
## 7. Access website
```
http://master:50070/dfshealth.html
```
