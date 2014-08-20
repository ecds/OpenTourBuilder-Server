.. _DEPLOYNOTES:

System Requirements
===================

General Requirements
--------------------
The server will need a webserver and access to a database server.

Ubuntu 10.04 LTS
----------------

    $ apt-get install python-dev python-setuptools libtiff4-dev libjpeg62-dev \
        zlib1g-dev libfreetype6-dev tcl8.5-dev tk8.5-dev python-tk

    $ pip install virtualenv

Ubuntu 12.04 LTS
----------------

    $ apt-get install python-dev python-setuptools libtiff4-dev libjpeg8-dev zlib1g-dev \
    libfreetype6-dev liblcms2-dev libwebp-dev tcl8.5-dev tk8.5-dev python-tk

    $ pip install virtualenv

Redhat
------

    $ yum install python-devel python-setuptools libtiff-devel libjpeg-devel \
    libzip-devel freetype-devel lcms2-devel libwebp-devel tcl-devel tk-devel

    $ pip install virtualenv
