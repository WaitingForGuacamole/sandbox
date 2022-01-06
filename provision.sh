apt-get update -y
apt-get upgrade -y
apt-get install -y nginx
echo "<html><head/><body><p><b>Hello World</b> (from server " $HOSTNAME ")</p></body></html>" > /var/www/html/index.html
echo "OK" > /var/www/html/healthprobe.html
