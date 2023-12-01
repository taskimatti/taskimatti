# First Install

create user

- `sudo adduser fuksipassi`

create ssh key

- `ssh-keygen -t rsa -b 4096 -C "fuksipassi"`
- `cat ~/.ssh/id_rsa.pub`

activate ssh key

- `???`

add it to docker group

- `sudo usermod -a -G docker fuksipassi`

unblock ports

- `sudo ufw allow 8080; sudo ufw allow 8081`

https://github.com/appleboy/ssh-action/blob/master/.github/workflows/ci.yml


Nginx reverse proxy

cp deploy/example.com with your values

- `sudo cp deploy/example.com /etc/nginx/sites-available/fuksipassi`

Change example.com to yourdomain.com

- `sed -i 's/example.com/yourdomain.com/g' /etc/nginx/sites-available/fuksipassi`

Enable site

- `sudo ln -s /etc/nginx/sites-available/fuksipassi /etc/nginx/sites-enabled/`

Certbot

- `sudo certbot --nginx -d yourdomain.com -d cms.yourdomain.com`
