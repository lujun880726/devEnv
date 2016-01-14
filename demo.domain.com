server
    {
        listen 80;
        #listen [::]:80;
        server_name devname.devpro.domain;
        index index.html index.htm index.php default.html default.htm default.php;
        root  /home/devname/devname.devpro.domainindexphpPath;

        include none.conf;
        #error_page   404   /404.html;


	location /
    	{
		if (!-e $request_filename) {
             		rewrite ^/(.*)$ /index.php?PATH_INFO=$1& last;
        	}
    	}

    	location ~ .*\.(php|php5)
    	{
        	fastcgi_pass  unix:/tmp/php-cgi.sock;
	        fastcgi_index index.php;
	        include fastcgi.conf;

   	}

        location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$
        {
            expires      0d;
        }

        location ~ .*\.(js|css)?$
        {
            expires      0h;
        }


        access_log  /home/devname/wwwlogs/devname.devpro.domain.log  access;
    }


