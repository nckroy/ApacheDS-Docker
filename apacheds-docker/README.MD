# Docker Apache Directory Server container

Copyright © 2022 Internet2, All Rights Reserved
Licensed under a Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) license

This container supplies an installation of Apache Directory Server which can be used in connection with other services/containers to bootstrap demos of components which depend on an LDAP directory, Kerberos, or both. Since the Apache Directory Server wrapper currently fails to run on non-Intel architectures, this container can be used on non-Intel x86-64-based architectures to provide a local instance of Apache Directory Server as follows:

Dependencies:

-Runtime environment such as Docker Desktop or similar
-For non-x86-64 architecture-based systems, the ability for your Docker to use the virtualization framework, qemu, or similar to emulate x86-64 architecture

Clone this repo, and then run:

`docker buildx build --platform linux/amd64 . -t apacheds`

This will build the container and push it to the local Docker repo. Then, run the container as follows:

`docker run --platform linux/amd64 -dt --name apacheds_container -p 10389:10389 -p 10636:10636 -p 60464:60464 -p 60464:60464/udp -p 60088:60088 -p 60088:60088/udp apacheds:latest`

This will start the container with the necessary ports for:

- LDAP binds
- LDAPS binds
- Remote password changes
- Kerberos KDC

You may then use a client tool such as Apache Directory Studio, the Apache Directory Studio Eclipse plugin, ldapsearch, or client libraries in your programming framework of choice to bind against the directory.

The superuser bind DN is: `cn=test,dc=example,dc=com`
The superuser bind password (plaintext) is: `secret5`

This user can be used to do anything you need to the directory, including serving as a test credential for login to other sysystems backed by this verifier.

It is advisable to change these defaults if you plan to run this container anywhere other than a locked-down development environment.
