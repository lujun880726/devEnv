server
    {
        listen 80;
        #listen [::]:80;
        server_name devname.devpro.jxch168.com;
        index index.html index.htm index.php default.html default.htm default.php;
        root  /home/devname/devname.devpro.jxch168.com;

        include none.conf;
        #error_page   404   /404.html;
        location ~ [^/]\.php(/|$)
        {
            # comment try_files $uri =404; to enable pathinfo
            try_files $uri =404;
            fastcgi_pass  unix:/tmp/php-cgi.sock;
            fastcgi_index index.php;
            include fastcgi.conf;
            #include pathinfo.conf;
        }

        location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$
        {
            expires      0d;
        }

        location ~ .*\.(js|css)?$
        {
            expires      0h;
        }

        access_log  /home/devname/wwwlogs/devname.devpro.jxch168.com.log  access;
    }


