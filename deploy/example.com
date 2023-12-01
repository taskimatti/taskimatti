server {
    server_name     example.dev;

    location / {
        proxy_set_header    X-Real-IP $remote_addr;
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header    X-Forwarded-Proto https;
        proxy_set_header    X-Forwarded-Port 443;
        proxy_pass          http://10.11.0.2:3000;
    }

    error_log /var/log/nginx/example.dev.error;
    access_log /var/log/nginx/example.dev.access;

    listen 80;
}

server {
    server_name     cms.example.dev;

    location / {
        proxy_pass  http://10.11.0.4:8055;
    }

    error_log /var/log/nginx/cms.example.dev.error;
    access_log /var/log/nginx/cms.example.dev.access;

    listen 80;
}
