FROM python:3-alpine

RUN pip3 install pelican Markdown ghp-import shovel pelican-minify typogrify invoke
RUN mkdir  /site
RUN apk update
RUN apk upgrade
RUN apk add make bash git
COPY update-themes.sh /usr/local/bin/update-themes
COPY quickstart.sh /usr/local/bin/quickstart
RUN chmod ug+x /usr/local/bin/quickstart /usr/local/bin/update-themes
COPY default_docker-compose.yml /var/lib/pelican/
COPY Makefile.host /var/lib/pelican/
WORKDIR /site
EXPOSE 8000
ARG IMAGE_TAG
RUN sed s!__IMAGE_TAG__!${IMAGE_TAG}! -i /var/lib/pelican/default_docker-compose.yml
CMD make devserver