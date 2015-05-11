FROM debian:jessie

MAINTAINER Natanael Arndt <arndt@informatik.uni-leipzig.de>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

# install some basic packages
RUN apt-get install -y patch apt-utils\
    libldap-2.4-2 libssl1.0.0

ADD virtuoso-opensource_7.1_amd64.deb /
RUN dpkg -i virtuoso-opensource_7.1_amd64.deb

#RUN apt-get -f install -y

ADD virtuoso.ini.patch /virtuoso.ini.patch
RUN patch /var/lib/virtuoso/db/virtuoso.ini < virtuoso.ini.patch

# expose the ODBC and management ports to the outer world
EXPOSE 1111
EXPOSE 8890

VOLUME "/var/lib/virtuoso/db"
WORKDIR /var/lib/virtuoso/db

# TODO also add some way of changing the password +pwdold dba +pwddba ${PWDDBA}
CMD ["/usr/bin/virtuoso-t", "-c", "virtuoso", "+foreground"]
