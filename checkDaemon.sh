#!/bin/bash
export update_time=$(date +%Y%m%d%H%M%S)

Folder_A=/home/wwwroot/www.baidu.com/cli/Daemon  
for file_a in ${Folder_A}/*; do  
    temp_file=`basename $file_a`  
    count=`ps -ef |grep $temp_file |grep -v "grep" |wc -l`
    if [ 0 == $count ];then
        nohup php ${Folder_A}/${temp_file} >> /tmp/${temp_file%.*}.out &

	echo [${update_time}] $temp_file ' is run!'
    else
	echo [${update_time}] $temp_file ' is there!'
    fi
done
