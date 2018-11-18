FROM python:3-alpine

RUN pip install pelican Markdown ghp-import shovel

RUN mkdir -p /srv/pelican-website
COPY pelican_default/ /srv/pelican-website
WORKDIR /srv/pelican-website
EXPOSE 8000
CMD pelican -s pelicanconf.py -lr -p 8000 --relative-urls