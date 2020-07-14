www.demo#!/bin/bash



#更新前把update中的server.php 恢复后再git pull
cd /home/www.demo.com.update/ && git checkout config/autoload/server.php
#更新
cd /home/www.demo.com
git pull origin production
chown -R nobody:nobody ./*

#更新UPDATE
cd /home/www.demo.com.update
git pull origin production
chown -R nobody:nobody ./*

#更新完代码 修改UPDATE中的端口号
sed -i 's/9501/9502/g' /home/www.demo.com.update/config/autoload/server.php
#如果只使用单服务修改UPDATE中的参数
sed -i "/log_file/a'worker_num' => 3,'task_worker_num' => 5," /home/www.demo.com.update/config/autoload/server.php

# 重启9502  -- 使用9501
cp /usr/local/nginx/conf/vhost/www.demo.com.conf.9501 /usr/local/nginx/conf/vhost/www.demo.com.conf

systemctl start nginx.service

nginx_tag=`ps -ef | grep nginx | grep shutting | wc -l`
while [ $nginx_tag -ne 0 ]
do
  sleep 1
  echo "wait update_hyperf"
  nginx_tag=`ps -ef | grep nginx | grep shutting | wc -l`
done

#cat /home/www.demo.com.update/runtime/hyperf.pid |xargs kill;php /home/www.demo.com.update/bin/hyperf.php start
pm2 stop serverStartUpdate
rm -rf /home/www.demo.com/runtime/container/*
rm -rf /home/www.demo.com/runtime/view/*
pm2 start serverStartUpdate

api_tag=`curl -I -m 10 -o /dev/null -s -w %{http_code} http://127.0.0.1:9502`
while [ $api_tag -ne 200 ]
do
  sleep 1
  echo "wait 9502:"
  echo $api_tag
  api_tag=`curl -I -m 10 -o /dev/null -s -w %{http_code} http://127.0.0.1:9502`
done
echo "9502 is ok"


# 重启9501 使用9502
cp /usr/local/nginx/conf/vhost/www.demo.com.conf.9502 /usr/local/nginx/conf/vhost/www.demo.com.conf


systemctl start nginx.service

nginx_tag=`ps -ef | grep nginx | grep shutting | wc -l`
while [ $nginx_tag -ne 0 ]
do
  sleep 1
  echo "wait update_hyperf"
  nginx_tag=`ps -ef | grep nginx | grep shutting | wc -l`
done

#cat /home/www.demo.com/runtime/hyperf.pid |xargs kill;php /home/www.demo.com/bin/hyperf.php start

pm2 stop  serverStart
rm -rf /home/www.demo.com/runtime/container/*
rm -rf /home/www.demo.com/runtime/view/*
pm2 start  serverStart


api_tag=`curl -I -m 10 -o /dev/null -s -w %{http_code} http://127.0.0.1:9501`
while [ $api_tag -ne 200 ]
do
  sleep 1
  echo "wait 9501:"
  echo $api_tag
  api_tag=`curl -I -m 10 -o /dev/null -s -w %{http_code} http://127.0.0.1:9501`
done
echo "9501 is ok"


#测试环境只开9501 方便查日志等操作
cp /usr/local/nginx/conf/vhost/www.demo.com.conf.9501 /usr/local/nginx/conf/vhost/www.demo.com.conf

systemctl start nginx.service

nginx_tag=`ps -ef | grep nginx | grep shutting | wc -l`
while [ $nginx_tag -ne 0 ]
do
  sleep 1
  echo "wait update_hyperf"
  nginx_tag=`ps -ef | grep nginx | grep shutting | wc -l`
done

echo "nginx to 9501 is ok "


#cat /home/www.demo.com.update/runtime/hyperf.pid |xargs kill;
pm2 stop serverStartUpdate

echo " 9502 down "
echo "all restaet is ok"
