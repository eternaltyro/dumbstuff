

TODO::Security
- Deny access to cache directories
- Deny access to hidden directories

  location ~ /\.* {
    deny all;
  }

- Deny access to version control directories

  location ~ /\.(git|svn|htaccess)$ {
        deny all;
  }

- Buffer overflow attack mitigation

  client_body_buffer_size  1K;
  client_header_buffer_size 1k;
  client_max_body_size 1k;
  large_client_header_buffers 2 1k;

  client_body_timeout   10;
  client_header_timeout 10;
  keepalive_timeout     5 5;
  send_timeout          10;

- Disable directory listing
  
  # Can also be done in server, location blocks
  http {
    ...
    autoindex off;
    ...
  }

TODO::Performance
- 
  location / {
      index index.php index.html index.htm;
      try_files $uri $uri/ @proxyone;
  }

  location @proxyone {
      rewrite ^(.*)$ /app.php/$1 last;
  }

TODO::Access Control
- 

