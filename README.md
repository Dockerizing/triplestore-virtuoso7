# Virtuoso 7 Docker Container

This container provided [OpenLink Virtuoso Open-Source](http://virtuoso.openlinksw.com/dataspace/doc/dav/wiki/Main/VOSIndex) ([@github](https://github.com/openlink/virtuoso-opensource)) in a container.
This container is not provided and maintained by OpenLink Software, so please don't blaim them for any malfunctions.

## Usage instructions

You can run the container with the following command.
Please provide a name to the container, you will need to link other containers with it.
The `-d` option runs the container in detached mode (in the background).

    docker run -d --name="<virtuoso container name>" <other argument see below> virtuoso7:latest

The image comes with a fallback configuration file (`virtuoso.ini`) and will store teh database files in the containers filesystem in `/var/lib/virtuoso/db/`.
If you want to persist the virtuoso database files on the host system you can mount a host directory as volume into the docker container.
You will also need to provide a configuration file with it.
The following argument includes the local directory to the container.

    -v <host virtuoso directory>:/var/lib/virtuoso/db

The default login for virtuoso is username and password `dba`.
You are encouraged to change the default password to some secret with the environment variabel `$PWDDBA` as follows.
(This environment variable will be available to other docer containers, which are linked to this container via the `--link` option.)

    -e PWDDBA="<your secret goes here>"

If you want to access the virtuoso directly from your host you can also expose the virtuoso port (`8890`) and the ODBC port (`1111`) with the following arguments:

    -p <your virtuoso port>:8890 -p <your odbc/jdbc port>:1111
