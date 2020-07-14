#!/bin/bash
#设置日志文件存放目录
Logdir="/home/wwwlogs/"
#设置pid文件
PidTag="/usr/local/nginx/logs/nginx.pid"
LogName=(www.demo1.com www.demo2.com)
#重命名日志文件
function swithlog()
{
  mv ${Logdir}/$1.log ${Logdir}/history/$1_$(date -d "yesterday" +"%Y%m%d").log
}
for i in ${LogName[@]}
do
  swithlog $i
done

#向nginx主进程发信号重新打开日志
kill -USR1 `cat ${PidTag}`
