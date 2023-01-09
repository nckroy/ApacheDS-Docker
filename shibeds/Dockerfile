FROM ubuntu:latest

ARG DEBIAN-FRONTEND=noninteractive

RUN apt-get update && apt-get install -y apt-transport-https && apt-get -y install less vim apache2 git python3 curl

COPY ["discofeed.json", "boot.sh", "/tmp/."]

RUN chmod +x /tmp/boot.sh

EXPOSE 10080

CMD ["sh", "-c", "/tmp/boot.sh"]
