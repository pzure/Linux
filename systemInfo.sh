#!/bin/bash

echo 'Hello'

OS='uname'

echo "Linux_OS : $(${OS})"

get_user_info(){

uname -a

}

get_cpu_num(){

grep "cpu cores" /proc/cpuinfo | head -n1 | awk '{ print $NF }'

}

get_linux_bit(){

getconf LONG_BIT

}

get_Linux_ip(){

ip a s | grep -w "inet" | awk 'NR==2{ print $2 }' | awk -F/ '{ print $1 }'

}

get_software_num(){

dpkg -l | tail -n +6 | wc -l

}

get_process(){

ps aux | tail -n +2 | wc -l

}

get_disk_size(){

df -h | grep -E "^.*/$" | awk '{ print $2 }'

}

get_memory_total(){

free -h | awk 'NR==2{ print $2 }'

}

get_memory_free(){

free -m | awk 'NR==2{ print $NF }'

}

echo "Linux info : $(get_user_info)"

echo "cpu number : $(get_cpu_num)"

echo "Linux Bit : $(get_linux_bit)"

echo "Your IP : $(get_Linux_ip)"

echo "check dpkg number : $(get_software_num)"

echo "run process number :$(get_process)"

echo "your install disk size :$(get_disk_size)"

echo "memory total : $(get_memory_total)"

echo "free memory :$(get_memory_free)"

echo "hostname :$(hostname)"

echo "CPU stauts : $(top -n1 |grep "Cpu(s):" |awk '{print echo "CPU stauts (%) : "$2 echo "%"}')"

echo "$(df -hT |grep /dev/sda |awk '{print echo "Disk Stauts (%):"$6}')"

echo "$(cat /proc/uptime| awk -F. '{run_days=$1 / 86400;run_hour=($1 % 86400)/3600;run_minute=($1 % 3600)/60;run_second=$1 % 60;printf("系统已运行：%d天%d时%d分%d秒",run_days,run_hour,run_minute,run_second)}')"

echo "OS for : $(head -n 1 /etc/issue)"

echo "内核版本 ： $(cat /proc/version)"

echo "发行版本 : $(lsb_release -a)"
