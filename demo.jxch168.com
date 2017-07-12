
server
    {
        listen 80;
        #listen [::]:80;
	server_name devname.devpro.wwwDomain  devname.chart.devpro.wwwDomain devname.api.devpro.wwwDomain devname.m.devpro.wwwDomain;
        index index.html index.htm index.php default.html default.htm default.php;
        root  /home/devname/devname.devpro.wwwDomain/htdocs;

        include none.conf;
        #error_page   404   /404.html;


	location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files $uri $uri/ /index.php?$query_string;
                # Uncomment to enable naxsi on this location
                # include /etc/nginx/naxsi.rules
        }


    	location ~ \.php$ {
                try_files $uri /index.php =404;
                fastcgi_split_path_info ^(.+\.php)(/.+)$;
                fastcgi_pass unix:/tmp/php-cgi.sock;
                fastcgi_index index.php;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                include fastcgi_params;
        }


        location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$
        {
            expires      0d;
        }

        location ~ .*\.(js|css)?$
        {
            expires      0h;
        }


	access_log  /home/devname/wwwlogs/devname.devpro.wwwDomain.log access ;
	error_log   /home/devname/wwwlogs/devname.devpro.wwwDomain.err.log;

    }
