#!/bin/bash


#机房
tt1=`curl --connect-timeout 10 -I -s web.jxch168.com|head -1|cut -d " " -f2`
if [ $tt1 == "200" ]
then
        echo 'OK'
else
	sleep 2
	tt1=`curl --connect-timeout 10 -I -s web.jxch168.com|head -1|cut -d " " -f2`
	if [ $tt1 == "200" ]
	then
		echo 'OK'
	else
		sleep 2
		tt1=`curl --connect-timeout 10 -I -s web.jxch168.com|head -1|cut -d " " -f2`
		if [ $tt1 == "200" ]
		then
			echo 'OK'
		else
			curl  "http://61.130.7.220:8023/MWGate/wmgw.asmx/MongateSendSubmit?userId=J50601&password=598712&pszMobis=13916497905&pszMsg=jxch-web-servererr&iMobiCount=1&pszSubPort=*&MsgId=123132122222""$RANDOM"
			curl  "http://61.130.7.220:8023/MWGate/wmgw.asmx/MongateSendSubmit?userId=J50601&password=598712&pszMobis=13761377369&pszMsg=jxch-web-servererr&iMobiCount=1&pszSubPort=*&MsgId=123132122222""$RANDOM"
			curl  "http://61.130.7.220:8023/MWGate/wmgw.asmx/MongateSendSubmit?userId=J50601&password=598712&pszMobis=15618388681&pszMsg=jxch-web-servererr&iMobiCount=1&pszSubPort=*&MsgId=123132122222""$RANDOM"
			echo 'err'
		fi
	fi
       
fi

#电信
tt1=`curl --connect-timeout 10 -I -s dx.jxch168.com|head -1|cut -d " " -f2`
if [ $tt1 == "200" ]
then
        echo 'OK'
else
	sleep 2
        tt1=`curl --connect-timeout 10 -I -s dx.jxch168.com|head -1|cut -d " " -f2`
	if [ $tt1 == "200" ]
	then
		echo 'OK'
	else
		sleep 2
		tt1=`curl --connect-timeout 10 -I -s dx.jxch168.com|head -1|cut -d " " -f2`
		if [ $tt1 == "200" ]
		then
			echo 'OK'
		else
			curl  "http://61.130.7.220:8023/MWGate/wmgw.asmx/MongateSendSubmit?userId=J50601&password=598712&pszMobis=13916497905&pszMsg=jxch-dx-servererr&iMobiCount=1&pszSubPort=*&MsgId=123132122222""$RANDOM"
			curl  "http://61.130.7.220:8023/MWGate/wmgw.asmx/MongateSendSubmit?userId=J50601&password=598712&pszMobis=13761377369&pszMsg=jxch-dx-servererr&iMobiCount=1&pszSubPort=*&MsgId=123132122222""$RANDOM"
			curl  "http://61.130.7.220:8023/MWGate/wmgw.asmx/MongateSendSubmit?userId=J50601&password=598712&pszMobis=15618388681&pszMsg=jxch-dx-servererr&iMobiCount=1&pszSubPort=*&MsgId=123132122222""$RANDOM"
			echo 'err'
		fi
	fi
fi


#联通
tt1=`curl --connect-timeout 10 -I -s lt.jxch168.com|head -1|cut -d " " -f2`
if [ $tt1 == "200" ]
then
        echo 'OK'
else
	sleep 2
        tt1=`curl --connect-timeout 10 -I -s lt.jxch168.com|head -1|cut -d " " -f2`
	if [ $tt1 == "200" ]
	then
		echo 'OK'
	else
		sleep 2
		tt1=`curl --connect-timeout 10 -I -s lt.jxch168.com|head -1|cut -d " " -f2`
		if [ $tt1 == "200" ]
		then
			echo 'OK'
		else
			curl  "http://61.130.7.220:8023/MWGate/wmgw.asmx/MongateSendSubmit?userId=J50601&password=598712&pszMobis=13916497905&pszMsg=jxch-lt-servererr&iMobiCount=1&pszSubPort=*&MsgId=123132122222""$RANDOM"
			curl  "http://61.130.7.220:8023/MWGate/wmgw.asmx/MongateSendSubmit?userId=J50601&password=598712&pszMobis=13761377369&pszMsg=jxch-lt-servererr&iMobiCount=1&pszSubPort=*&MsgId=123132122222""$RANDOM"
			curl  "http://61.130.7.220:8023/MWGate/wmgw.asmx/MongateSendSubmit?userId=J50601&password=598712&pszMobis=15618388681&pszMsg=jxch-lt-servererr&iMobiCount=1&pszSubPort=*&MsgId=123132122222""$RANDOM"
			echo 'err'
		fi
	fi
fi
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
			curl  "http://61.130.7.220:8023/MWGate/wmgw.asmx/MongateSendSubmit?userId=J50601&password=598712&pszMobis=13916497905&pszMsg=fuiou-error&iMobiCount=1&pszSubPort=*&MsgId=123132122222""$RANDOM"
			curl  "http://61.130.7.220:8023/MWGate/wmgw.asmx/MongateSendSubmit?userId=J50601&password=598712&pszMobis=13761377369&pszMsg=fuiou-error&iMobiCount=1&pszSubPort=*&MsgId=123132122222""$RANDOM"
			curl  "http://61.130.7.220:8023/MWGate/wmgw.asmx/MongateSendSubmit?userId=J50601&password=598712&pszMobis=15618388681&pszMsg=fuiou-error&iMobiCount=1&pszSubPort=*&MsgId=123132122222""$RANDOM"
			echo 'err'
		fi
	fi
fi