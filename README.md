

Lightweight container for a Pelican blog.

The image is built for both ARM and AMD64 architectures, so it is suitable for running on a Raspberry Pi.

The default entrypoint continuously regenerates the site directory bound to `/site`, assuming that content is in `/site/content` and output is to go to `/site/output`. The development server is also run for that site, exposed from the container on port 8000.

However, while using that setup is helpful for development, it's probably not what you want to do in production. Running a container with the `pelican-quickstart` and `invoke` commands described below gives you more control.

# Configuration

To set up a new site you're going to want to bind a host directory to somewhere on the container: I recommend using `/site` on the container side since this is the working directory that the image is configured to run in. Initialize your site with

	docker run --rm --user $(id -u):$(id -g) -it -v /host/site/path:/site whatang/docker-pelican quickstart

This will ask you some questions about how you want your site configured. Just choosing the defaults is an OK way to get started. It will setup some directories for you, `pelicanconf.py` and `publishconf.py` files, and some configuration file. You must say "yes" to the option asking if you want a `Makefile` and `tasks.py` file created for you.

The `--user` option sets up all the created files and directories as the current user: this allows you to modify and write to them without being root.

The container will expect to find your content at `/site/content` and will output the site files at `/site/output`. It will also create `Makefile` and `docker-compose.yml` files in your `/host/site/path` which will make it easy for you to manage your site.



# Using the site

`docker-pelican` uses Pelican's `pelican-quickstart` to create a sensible configuration, and provides some supporting infrastructure to make it easy to manage your website in the container.

## Building

Once you've written your site content, you'll want to build it.

    make html

To do continuous regeneration whenever any file changes, do

    make regenerate


## Serving a development version of your site

After you've built the site, do:

	make serve

This will serve your site from the container at port 8000 (unless you changed the port mapping in the `docker-compose.yml` file).

Alternatively, to have your site continually rebuild any changes while serving, do:

	make devserver

## Passing options to Pelican

If you want to specify any additional options to Pelican you can add them to the `PELICAN_OPTS=` line in `Makefile.container`.

Alternatively, you can specify them as an argument to the `make` command you run on your host - these will overwrite anything in `Makefile.container`:

	make html PELICANOPTS="some options here..."

## Themes

There is a script in the container which will download all the themes from https://github.com/getpelican/pelican-themes. Run:

	make themes

This will clone the themes into the host's `themes` subdirectory, or update them if you've already done so.

To use a theme, it needs to be passed as a Pelican option. To use the bootstrap theme we could do:

	make themes
	make html PELICANOPTS="-t themes/bootstrap"

or edit the `Makefile.container` and set the `PELICANOPTS=` line to

	PELICANOPTS="-t themes/bootstrap"

# The Makefile and docker-compose.yml

The `Makefile` and `docker-compose.yml` files work together to make it easy to run standard Pelican operation on your site. The compose file defines the volume bindings and port mappings needed to run your container, as well as the precise version of `docker-pelican` to run. Editing the compose file will allow you to change any of these values.

The `Makefile` simply proxies its targets to the container using `docker-compose` and the compose file, passing its targets to the `Makefile.container`.
