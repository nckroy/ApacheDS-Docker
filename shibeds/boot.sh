#! /bin/sh

curl https://shibboleth.net/downloads/embedded-discovery-service/1.2.2/shibboleth-embedded-ds-1.2.2.tar.gz -o /tmp/shibboleth-embedded-ds-1.2.2.tar.gz
cd /tmp
tar zxpvf /tmp/shibboleth-embedded-ds-1.2.2.tar.gz
cd shibboleth-embedded-ds-1.2.2
make install
mkdir -p /var/www/html/Shibboleth.sso
mv /tmp/discofeed.json /var/www/html/Shibboleth.sso/DiscoFeed
rm -f /var/www/html/index.html
mv /etc/shibboleth-ds/* /var/www/html/.
rm -f /var/www/html/idpselect_config.js
mv /tmp/idpselect_config.js /var/www/html/.
mv /tmp/test-eds.html /var/www/html/
rm -f /etc/apache2/ports.conf
mv /tmp/ports.conf /etc/apache2/.
/sbin/apache2ctl start

sleep infinity
