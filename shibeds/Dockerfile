FROM ubuntu:latest

ARG DEBIAN-FRONTEND=noninteractive

RUN apt-get update && apt-get install -y apt-transport-https && apt-get -y install less vim make apache2 git python3 curl

COPY ["discofeed.json", "boot.sh", "idpselect_config.js", "test-eds.html", "ports.conf",  "/tmp/"]

RUN chmod +x /tmp/boot.sh

EXPOSE 80
EXPOSE 443

CMD ["sh", "-c", "/tmp/boot.sh"]
