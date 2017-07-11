#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin/expect:~/bin
export PATH
nginxPath=/opt/lnmp1.2/nginx
baseDomain=tubiaojiao.com

echo "Please setup samba user name"
read -p "Please enter: " sambaUsername
if [ "${sambaUsername}" = "" ]; then
	echo "sambaUsername is not null!"
	exit 0
fi
echo "sambaUsername: ${sambaUsername}"


echo "Please setup samba user [${sambaUsername}] passwd"
read -p "Please enter: " sambaUsernamewd
if [ "${sambaUsernamewd}" = "" ]; then
        echo "sambaUsername passwd is not null!"
        exit 0
fi
echo "sambaUsernamewd: ${sambaUsernamewd}"

echo "create sysuser ,but not login system"

useradd -d /home/"${sambaUsername}"  -g www -m "${sambaUsername}"
sleep 2


echo "create sysuser finshed"

echo "smbasswd samba user"

smbpasswd -a "${sambaUsername}" <<EOF
${sambaUsernamewd}
${sambaUsernamewd}
EOF

echo "smbasswd finshed"

echo "write smb.conf"

echo "[${sambaUsername}]" >> /etc/samba/smb.conf
echo "path = /home/${sambaUsername}" >> /etc/samba/smb.conf
echo "valid users = ${sambaUsername}" >> /etc/samba/smb.conf
echo "#browsable =yes" >> /etc/samba/smb.conf
echo "writable = yes" >> /etc/samba/smb.conf
echo "#guest ok = no" >> /etc/samba/smb.conf
echo "#read only = no" >> /etc/samba/smb.conf

echo "write smb.conf finshed"

echo "create new nginx conf"

cp ${nginxPath}/conf/vhost/dev.${baseDomain}.conf ${nginxPath}/conf/vhost/${sambaUsername}.${baseDomain}.conf

echo "edit nginx conf"

#sed -i "s/dev/${sambaUsername}.dev/g" ${nginxPath}/conf/vhost/${sambaUsername}.jxch168.com.conf
sed -i "s/\/data\/www\/dev.${baseDomain}\/home\/${sambaUsername}\/${sambaUsername}.dev.${baseDomain}/g" ${nginxPath}/conf/vhost/${sambaUsername}.${baseDomain}.conf
sed -i "s/\/data\/wwwlogs\/dev.${baseDomain}/\/home\/${sambaUsername}\/wwwlogs\/${sambaUsername}.dev.${baseDomain}/g" ${nginxPath}/conf/vhost/${sambaUsername}.${baseDomain}.conf
sed -i "/server_name/ s/dev.${baseDomain}/${sambaUsername}.dev.${baseDomain}/g" ${nginxPath}/conf/vhost/${sambaUsername}.${baseDomain}.conf
#sed -i "s/wwwlogs/${sambaUsername}\/wwwlogs/g" ${nginxPath}/conf/vhost/${sambaUsername}.jxch168.com.conf
#sed -i "s/wwwroot/${sambaUsername}/g" ${nginxPath}/conf/vhost/${sambaUsername}.jxch168.com.conf
#sed -i "s/jxch.5pa.cn//g" ${nginxPath}/conf/vhost/${sambaUsername}.jxch168.com.conf


echo "mkdir path & chmod "

mkdir -p /home/${sambaUsername}/${sambaUsername}.dev.${baseDomain}
mkdir -p /home/${sambaUsername}/wwwlogs
chown -R ${sambaUsername}:smbgrp /home/${sambaUsername}/
chmod -R a+rwxt /home/${sambaUsername}/
chmod -R 777 /home/${sambaUsername}/


echo "create index.php "
echo "<?php phpinfo();?>" >> /home/${sambaUsername}/${sambaUsername}.dev.${baseDomain}/index.php

echo "nginx restart"

/etc/init.d/nginx restart
service smbd restart
