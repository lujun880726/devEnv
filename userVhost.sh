#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin/expect:~/bin
export PATH
nginxPath=/opt/lnmp1.2/nginx
defaultDomain=jxch168.com
defaultindexphpPath=
limit_ex=/



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


echo "Please setup domain .if is null domain is " ${defaultDomain}
read -p "Please enter: "  domain
if [ "${domain}" = "" ]; then
        domain=${defaultDomain}
fi
echo "domain: ${domain}"


echo "Please setup index.php default path .if is null default is " ${defaultindexphpPath}
read -p "Please enter: "  indexphpPath
echo ${indexphpPath}
if [ "${indexphpPath}" = "" ]; then
        indexphpPath=${defaultindexphpPath}
else
	indexphpPath=${indexphpPath}
fi

echo "indexphpPath: ${indexphpPath}"





echo "create new nginx conf"

cp ./demo.domain.com ${nginxPath}/conf/vhost/${devname}.${devpro}.${domain}.conf

echo "edit nginx conf"

sed -i "s/devname/${devname}/g" ${nginxPath}/conf/vhost/${devname}.${devpro}.${domain}.conf
sed -i "s/devpro/${devpro}/g" ${nginxPath}/conf/vhost/${devname}.${devpro}.${domain}.conf
sed -i "s/domain/${domain}/g" ${nginxPath}/conf/vhost/${devname}.${devpro}.${domain}.conf

if [ "${indexphpPath}" = "" ]; then
 sed -i "s/indexphpPath/${indexphpPath}/g" ${nginxPath}/conf/vhost/${devname}.${devpro}.${domain}.conf
else
 sed -i "s/indexphpPath/\/${indexphpPath}/g" ${nginxPath}/conf/vhost/${devname}.${devpro}.${domain}.conf
fi



echo "mkdir path & chmod "


if [ ! -d /home/${devname} ] ; then
	mkdir -p /home/${devname}/
	chown -R ${devname}:www /home/${devname}/
fi
if [ ! -d /home/${devname}/${devname}.${devpro}.${domain} ] ; then
	mkdir -p /home/${devname}/${devname}.${devpro}.${domain}
	chown -R ${devname}:www /home/${devname}/${devname}.${devpro}.${domain}
fi

if [ ! -d /home/${devname}/wwwlogs ] ; then
	mkdir -p /home/${devname}/wwwlogs
	chown -R ${devname}:www /home/${devname}/wwwlogs
fi

chmod -R 775 /home/${devname}/


echo "create index.php "

if [ "${indexphpPath}" != "" ]; then
	if [ ! -d /home/${devname}/${devname}.${devpro}.${domain}/${indexphpPath} ] ; then
        	mkdir -p /home/${devname}/${devname}.${devpro}.${domain}/${indexphpPath}
	        chown -R ${devname}:www /home/${devname}/${devname}.${devpro}.${domain}/${indexphpPath}
	fi
	echo "<?php phpinfo();?>" >> /home/${devname}/${devname}.${devpro}.${domain}/${indexphpPath}/index.php
else
	echo "<?php phpinfo();?>" >> /home/${devname}/${devname}.${devpro}.${domain}/index.php
fi


chown -R ${devname}:www  /home/${devname}/${devname}.${devpro}.${domain}/

echo "nginx restart"

/etc/init.d/nginx restart
service smbd restart
