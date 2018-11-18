

Lightweight container for a Pelican blog.

This image has the themes at https://github.com/getpelican/pelican-themes built into it for easy use.

The image is built for both ARM and AMD64 architectures, so it is suitable for running on a Raspberry Pi.

# Running 

	docker run --rm -p 8080:80 whatang/docker-pelican

will serve a default empty site, using the bootstrap theme, on port 8080 of the host.

# Configuration
An empty site is pretty boring. You're going to want a real site. On your host, install pelican:

	pip install pelican

In a directory where you want to work on the blog use pelican's quickstart script to set everything up nicely:

	cd /my/pelican/data
	pelican-quickstart

It will ask you some questions. Once you're finished it creates directories for you, and writes a `pelicanconf.py` file.

Now we just need to tell docker-pelican where everything is when we start the container. docker-pelican expects to find:
* `pelicanconf.py` at `/site/pelicanconf.py`
* the site content at `/site/content/`
* an output directory at `/site/output`

So to run our new site we need to bind these locations:

	docker run --rm -p 8080:80 -v /my/pelican/data:/site -v /my/pelican/data/content:/site/content -v/my/pelican/data/output:/site/output whatang/docker-pelican

(In fact you don't even need to bind the output directory if you don't want access to those files from outside the container.)

That's it: your site will now be served on port 8080 of the container/host.

## Themes

By default, docker-pelican uses the bootstrap theme, but all themes from https://github.com/getpelican/pelican-themes have been downloaded at image build time (you may need to rebuild if you want updated themes). These themes are all stored in the `/themes `directory in the container. If you want to change theme just set the `THEME` environment variable for the container to the path to the new theme: `THEME` defaults to `/themes/bootstrap`.