apt install -y python3-pip cron
pip install -U git+https://github.com/kontorol/hiddify-monitoring
pip install bottle pandas numpy

systemctl stop hiddify_monitoring_web.service
mkdir -p ../log/stats/
ln -s $(pwd)/hiddify_monitoring_web.service /etc/systemd/system/hiddify_monitoring_web.service

echo "0,15,30,45 * * * * root $(pwd)/cron.sh" > /etc/cron.d/hiddify-monitoring
service cron reload

