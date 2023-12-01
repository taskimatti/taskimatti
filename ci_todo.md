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
