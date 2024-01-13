## Hadoop-cluster-setup
This is a demonstration of using Terraform to setup Hadoop cluster
## Prerequisites
* [git](https://git-scm.com/downloads)
* [awscli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
* [config-profile](https://docs.aws.amazon.com/cli/latest/reference/configure/)
* [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
## 1. Build image
Go to [Packer-Hadoop](https://github.com/haquocdat543/Packer-Hadoop.git) and follow instruction to build image
## 2. Clone repository
```
git clone https://github.com/haquocdat543/Hadoop-cluster-setup.git
cd Hadoop-cluster-setup
```
## 3. Reconfigure
* Edit `ami-id` in `variable.tf` you have created in `Step 1`
## 4. Initialize infrastructure
```
terraform init
```
```
terraform apply --auto-approve
```
Then type your keypair name. If you dont have, create one. [Keypair](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html)

## 5. Destroy infrastructure
```
terraform destroy --auto-approve
```

## 6. Install JDK
```
sudo su -
apt-get update
apt-get upgrade -y
```
```
apt-get install openjdk-8-jdk -y
```

## 7. Set hostname
```
vi /etc/hosts
G
o
35.74.151.181 hadoop1
52.68.15.189 hadoop2
```

## 8. Environment
```
su - ubuntu
vi ~/.bashrc
:set paste
G
o
# Set hadoop environment variables
export HADOOP_HOME=$HOME/hadoop
export HADOOP_CONF_DIR=$HOME/hadoop/etc/hadoop
export HADOOP_MAPRED_HOME=$HOME/hadoop
export HADOOP_COMMON_HOME=$HOME/hadoop
export HADOOP_HDFS_HOME=$HOME/hadoop
export YARN_HOME=$HOME/hadoop
export PATH=$PATH:$HOME/hadoop/bin

# Set Java environment variables
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=/usr/lib/jvm/java-8-openjdk-amd64/bin:$PATH
```

## 9. Add Master
```
vi ~/hadoop/etc/hadoop/masters
:set paste
G
o
hadoop1
```
## 10. Add Slaves
```
vi ~/hadoop/etc/hadoop/slaves
:set paste
G
o
hadoop2
```
## 11. Files
`vi ~/hadoop/etc/hadoop/core-site.xml`
```
vi ~/hadoop/etc/hadoop/core-site.xml
:set paste
G
dd
dd
o
<configuration>
    <property>
        <name>fs.default.name</name>
        <value>hdfs://hadoop1:9000</value>
    </property>
</configuration>
```
Master
`vi ~/hadoop/etc/hadoop/hdfs-site.xml`
```
vi ~/hadoop/etc/hadoop/hdfs-site.xml
:set paste
G
dd
dd
dd
dd
o
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>2</value>
    </property>
    <property>
        <name>dfs.permissions.enabled</name>
        <value>true</value>
    </property>
    <property>
        <name>dfs.namenode.secondary.http-address</name>
        <value>hadoop1</value>
    </property>
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>/home/ubuntu/hadoop/namenode</value>
    </property>
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>/home/ubuntu/hadoop/datanode</value>
    </property>
</configuration>
```
Slave
`vi ~/hadoop/etc/hadoop/hdfs-site.xml`
```
vi ~/hadoop/etc/hadoop/hdfs-site.xml
:set paste
G
dd
dd
dd
dd
o
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>2</value>
    </property>
    <property>
        <name>dfs.permissions.enabled</name>
        <value>true</value>
    </property>
    <property>
        <name>dfs.namenode.secondary.http-address</name>
        <value>hadoop1:50090</value>
    </property>
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>/home/ubuntu/hadoop/datanode</value>
    </property>
</configuration>
```
`vi ~/hadoop/etc/hadoop/yarn-site.xml`
```
vi ~/hadoop/etc/hadoop/yarn-site.xml
:set paste
G
dd
dd
dd
dd
dd
o
<configuration>
   <property>
       <name>yarn.nodemanager.aux-services</name>
       <value>mapreduce_shuffle</value>
   </property>
   <property>
       <name>yarn.nodemanager.auxservices.mapreduce.shuffle.class</name>
       <value>org.apache.hadoop.mapred.ShuffleHandler</value>
   </property>
</configuration>
```
`vi ~/hadoop/etc/hadoop/mapred-site.xml`
```
vi ~/hadoop/etc/hadoop/mapred-site.xml
:set paste
G
dd
dd
dd
o
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
```
## 13. Generate key
```
ssh-keygen -b 4096





```
```
vi ~/.ssh/master_rsa
```
```
chmod 600 ~/.ssh/master_rsa
```
```
cat ~/.ssh/id_rsa.pub | ssh -i ~/.ssh/master_rsa ubuntu@hadoop1 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
```
```
cat ~/.ssh/id_rsa.pub | ssh -i ~/.ssh/master_rsa ubuntu@hadoop2 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
```

## 14. Environment
```
sudo su -
vi /etc/environment
G
o
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
```
```
source /etc/environment
```

## 15. On Master
```
su - ubuntu
hdfs namenode -format
```
```
cd $HADOOP_HOME
./sbin/start-all.sh
```
## 16. Check daemon Master
```
jps
```
## 17. Access website
```
http://master:50070
```
