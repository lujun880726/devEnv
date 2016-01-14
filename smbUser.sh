#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin/expect:~/bin
export PATH
nginxPath=/opt/lnmp1.2/nginx

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

useradd -d /home/"${sambaUsername}"  -g smbgrp -G www -m "${sambaUsername}" 
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

service smbd restart



