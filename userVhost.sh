#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin/expect:~/bin
export PATH
nginxPath=/opt/lnmp1.2/nginx

echo "Please setup devname  "
read -p "Please enter: " devname
if [ "${devname}" = "" ]; then
	echo "devname is not null!"
	exit 0
fi
echo "devname: ${devname}"

echo "Please setup devpro  "
read -p "Please enter: " devpro
if [ "${devpro}" = "" ]; then
	echo "devpro is not null!"
	exit 0
fi
echo "devpro: ${devpro}"



echo "create new nginx conf"

cp ./demo.jxch168.com ${nginxPath}/conf/vhost/${devname}.${devpro}.jxch168.com.conf

echo "edit nginx conf"

sed -i "s/devname/${devname}/g" ${nginxPath}/conf/vhost/${devname}.${devpro}.jxch168.com.conf
sed -i "s/devpro/${devpro}/g" ${nginxPath}/conf/vhost/${devname}.${devpro}.jxch168.com.conf

echo "mkdir path & chmod "


if [ ! -d /home/${devname} ] ; then
	mkdir -p /home/${devname}/
	chown -R ${devname}:smbgrp /home/${devname}/
fi
if [ ! -d /home/${devname}/${devname}.${devpro}.jxch168.com ] ; then
	mkdir -p /home/${devname}/${devname}.${devpro}.jxch168.com
	chown -R ${devname}:smbgrp /home/${devname}/${devname}.${devpro}.jxch168.com
fi

if [ ! -d /home/${devname}/wwwlogs ] ; then
	mkdir -p /home/${devname}/wwwlogs
	chown -R ${devname}:smbgrp /home/${devname}/wwwlogs
fi

chmod -R 775 /home/${devname}/


echo "create index.php "
echo "<?php phpinfo();?>" >> /home/${devname}/${devname}.${devpro}.jxch168.com/index.php

echo "nginx restart"

/etc/init.d/nginx restart
service smbd restart
