apt-get install -y nginx certbot python3-certbot-nginx
systemctl stop nginx
pkill -9 nginx
mkdir -p ../log

rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/nginx.conf

ln -s $(pwd)/nginx.conf /etc/nginx/nginx.conf

openssl req -x509 -newkey rsa:2048 -keyout selfsigned.key -out selfsigned.crt -days 3650 -nodes -subj "/C=GB/ST=London/L=London/O=Google Trust Services LLC/CN=www.google.com"


