# Docker Apache Directory Server container

Copyright © 2022 Internet2, All Rights Reserved
Licensed under a Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) license

This container supplies a preconfigured instance of the Shibboleth Embedded Discovery Service with an appropriate multilateral federation discofeed JSON document

Dependencies:

-Runtime environment such as Docker Desktop or similar

To build, clone this repo, and then run:

`docker build . -t shibeds`

This will build the container and push it to the local Docker repo. Then, run the container as follows:

`docker run --platform linux/amd64 -dt --name shibeds_container -p 10080:80 shibeds:latest`

This will start the container with the necessary port for web requests proxied to port 10080 on the host system.
