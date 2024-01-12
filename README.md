# Hadoop-cluster-setup
This is a demonstration of using Terraform to setup Hadoop cluster
## Files
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

