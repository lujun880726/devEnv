#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin/expect:~/bin
export PATH
nginxPath=/usr/local/nginx


echo "Please setup devname  "
read -p "Please enter: " devname
if [ "${devname}" = "" ]; then
	echo "devname is not null!"
	exit 0
fi
echo "devname: ${devname}"

echo "Please setup devdomain "
read -p "Please enter: " devdomain
if [ "${devdomain}" = "" ]; then
	echo "devdomain is not null!"
	exit 0
fi
echo "devname: ${devdomain}"



rm -rf ${nginxPath}/conf/vhost/${devdomain}.conf
rm -rf /home/${devname}/${devdomain}