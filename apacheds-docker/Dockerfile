FROM ubuntu:latest

ARG DEBIAN-FRONTEND=noninteractive

RUN apt-get update && apt-get install -y apt-transport-https && apt-get -y install less vim apacheds ldap-utils && rm -f /etc/init.d/apacheds

COPY ["sample-data.ldif", "boot.sh", "/tmp/"]

RUN chmod +x /tmp/boot.sh

EXPOSE 10389 10636 60464 60464/udp 60088 60088/udp

CMD ["sh", "-c", "/tmp/boot.sh"]
