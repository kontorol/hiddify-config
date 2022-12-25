apt-get install -y nginx certbot python3-certbot-nginx
systemctl stop nginx
pkill -9 nginx
mkdir -p ../log

mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
mv /etc/nginx/sites-enabled/default /etc/nginx/sites-enabled/default.bak
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak

ln -s $(pwd)/nginx.conf /etc/nginx/nginx.conf

openssl req -x509 -newkey rsa:2048 -keyout selfsigned.key -out selfsigned.crt -days 3650 -nodes -subj "/C=GB/ST=London/L=London/O=Google Trust Services LLC/CN=www.google.com"


