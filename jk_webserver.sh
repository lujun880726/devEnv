#!/bin/bash



#富友
tt1=`curl --connect-timeout 10 -I -s https://jzh.fuiou.com|head -1|cut -d " " -f2`
if [ $tt1 == "200" ]
then
        echo 'OK'
else
	sleep 2
        tt1=`curl --connect-timeout 10 -I -s https://jzh.fuiou.com|head -1|cut -d " " -f2`
	if [ $tt1 == "200" ]
	then
		echo 'OK'
	else
		sleep 2
		tt1=`curl --connect-timeout 10 -I -s https://jzh.fuiou.com|head -1|cut -d " " -f2`
		if [ $tt1 == "200" ]
		then
			echo 'OK'
		else
			curl  "http://短信""$RANDOM"
			curl  "http://短信""$RANDOM"
			curl  "http://短信""$RANDOM"
			echo 'err'
		fi
	fi
fi
