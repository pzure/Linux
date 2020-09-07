配置hosts文件

127.0.0.1   localhost

192.168.106.128  oradb

创建用户及目录

root用户执行：

groupadd -g 5001 dba

groupadd -g 5002 asmdba

groupadd -g 5003 backupdba

groupadd -g 5004 dgdba

groupadd -g 5005 kmdba

groupadd -g 5006 racdba

groupadd -g 5007 oper

groupadd -g 5008 oinstall

 

/usr/sbin/useradd -u 54321 -g oinstall -G dba,asmdba,backupdba,dgdba,kmdba,racdba,oper oracle

 

mkdir -p /u01/app/oracle/{oraInventory,product/19.2.0/db}

chown -R oracle:oinstall /u01

chmod -R 775 /u01

 

passwd oracle

编辑/etc/security/limits.conf

/etc/security/limits.conf中增加如下几行

oracle              soft    nproc   8192

oracle              hard    nproc   16384

oracle              soft    nofile  8192

oracle              hard    nofile  65536

 

编辑 vi /etc/ssh/sshd_config
 

修改#GSSAPIAuthentication yes

GSSAPIAuthentication no

修改#UseDNS yes

UseDNS no

关闭防火墙

[root@oradb ~]# systemctl status firewalld.service

[root@oradb ~]# systemctl stop firewalld.service

[root@oradb ~]# systemctl disable firewalld.service

 

关闭selinux
 

sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

 

编辑/etc/sysctl.conf
 

kernel.sem = 250 32000 100 128

fs.file-max = 6815744

net.core.rmem_default = 262144

net.core.rmem_max = 4194304

net.core.wmem_default = 262144

net.core.wmem_max = 1048576

 

# sysctl –p

编辑profile文件

#vi /etc/profile

# for oracle setting 在文档内加入以下内容

if [ $USER = "oracle" ]; then

        if [ $SHELL = "/bin/ksh" ]; then

              ulimit -p 16384

              ulimit -n 65536

        else

              ulimit -u 16384 -n 65536

        fi

fi

 

配置oracle环境变量
oracle用户:

$ cd

$ vi .bash_profile

加入：

export ORACLE_BASE=/u01/app/oracle

export ORACLE_HOME=$ORACLE_BASE/product/19.2.0/db

export ORACLE_SID=oradb

export ORACLE_TERM=xterm

export ORACLE_OWNER=oracle

export TNS_ADMIN=$ORACLE_HOME/network/admin

export ORA_NLS33=$ORACLE_HOME/ocommon/nls/admin/data

export NLS_LANG="AMERICAN_AMERICA.ZHS16GBK"

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$ORACLE_HOME/network/lib:/lib:/usr/lib:/usr/local/lib

export LIBPATH=$ORACLE_HOME/lib:$ORACLE_HOME/network/lib:/lib:/usr/lib:/usr/local/lib

export PATH=$PATH:/sbin:/usr/lbin:/usr/sbin:$JAVA_HOME/bin:$ORACLE_HOME/bin:$ORACLE_HOME/lib:$HOME/bin:$ORACLE_HOME/OPatch:.

umask 022

 

注意：修改完.bash_profile配置文件之后，oracle用户需要重新SSH登录，所设定的环境变量才会真正生效。

 

第四章 安装Oracle软件
上传Oracle19C安装包(oracle身份)
以oracle用户身份通过FTP方式上传安装包至Linux主机目录：cd $ORACLE_HOME (即oracle用户的home主目录下)

cd $ORACLE_HOME

/u01/app/oracle/product/19.2.0/db

 

V981623-01.zip

 

通过Xshell登录linux(oracle身份)
Xshell为Xmanager工具套件中所包含的xstart客户端，推荐使用此工具。

或也可以通过ilo界面，直接通过oracle用户登录，在图形界面上安装。

执行解压操作(Xmanager工具操作)
cd $ORACLE_HOME

/u01/app/oracle/product/19.2.0/db

 

unzip  V981623-01.zip

 

执行命令：cd  $ORACLE_HOME然后运行./runInstaller
切换至database子目录下，运行./runInstaller

 (oracle身份)，即可出现图形化的安装界面。

注意：以oracle用户登录执行
