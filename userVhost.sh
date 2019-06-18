#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin/expect:~/bin
export PATH
nginxPath=/usr/local/nginx
wwwDomain=zhimafx.xyz

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

echo "Please setup svnProName  "
read -p "Please enter: " svnProName
if [ "${svnProName}" = "" ]; then
        echo "svnProName is not null!"
        exit 0
fi
echo "svnProName: ${svnProName}"


echo "create new nginx conf"

cp ./demo.zhimfx.xyz ${nginxPath}/conf/vhost/${devname}.${devpro}.${wwwDomain}.conf

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

cd /home/${devname}/${devname}.${devpro}.${wwwDomain}

scp 192.168.0.21:/home/wwwroot/svnAm/conf/passwd ./
dos2unix passwd
svnUserInfo=`cat passwd|grep ${devname}i`"="
svnuser=`grep ${devname} passwd | awk -F= '{print $1}'`
svnpwd=`grep ${devname} passwd | awk -F= '{print $2}'`


sudo -Hu ${devname} svn checkout --username ${svnuser} --password ${svnpwd} svn://192.168.0.21/${svnProName}/trunk . <<EOF
yes
EOF


chmod -R 777 storage/

rm -rf ./passwd



echo "nginx restart"

/etc/init.d/nginx restart
