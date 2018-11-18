FROM python:3-alpine

RUN pip3 install pelican Markdown ghp-import shovel pelican-minify typogrify invoke
RUN apk add git
RUN mkdir  /site /site/output /site/content /themes
COPY pelicanconf.py /site
RUN git clone https://github.com/getpelican/pelican-themes.git /themes
WORKDIR /site
EXPOSE 80
CMD pelican -t ${THEME:-/themes/bootstrap} -o /site/output -s /site/pelicanconf.py -lr -p 80 --relative-urls /site/content