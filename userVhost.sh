#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin/expect:~/bin
export PATH
nginxPath=/usr/local/nginx
wwwDomain=demo.com

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

cp ./demo.demo.com ${nginxPath}/conf/vhost/${devname}.${devpro}.${wwwDomain}.conf

echo "edit nginx conf"

sed -i "s/devname/${devname}/g" ${nginxPath}/conf/vhost/${devname}.${devpro}.${wwwDomain}.conf
sed -i "s/devpro/${devpro}/g" ${nginxPath}/conf/vhost/${devname}.${devpro}.${wwwDomain}.conf
sed -i "s/wwwDomain/${wwwDomain}/g" ${nginxPath}/conf/vhost/${devname}.${devpro}.${wwwDomain}.conf

echo "mkdir path & chmod "


if [ ! -d /home/${devname} ] ; then
	mkdir -p /home/${devname}/
	chown -R ${devname}:www /home/${devname}/
fi
if [ ! -d /home/${devname}/${devname}.${devpro}.${wwwDomain} ] ; then
	mkdir -p /home/${devname}/${devname}.${devpro}.${wwwDomain}
	chown -R ${devname}:www /home/${devname}/${devname}.${devpro}.${wwwDomain}
fi

if [ ! -d /home/${devname}/wwwlogs ] ; then
	mkdir -p /home/${devname}/wwwlogs
	chown -R ${devname}:www /home/${devname}/wwwlogs
fi

chmod -R 775 /home/${devname}/


echo "create index.php "
echo "<?php phpinfo();?>" >> /home/${devname}/${devname}.${devpro}.${wwwDomain}/index.php

echo "nginx restart"

/etc/init.d/nginx restart
