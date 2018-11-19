#!/bin/bash
pelican-quickstart
cp /var/lib/pelican/default_docker-compose.yml /site/docker-compose.yml
cp /site/Makefile /site/Makefile.container
cp /var/lib/pelican/Makefile.host /site/Makefile
 
 
