SSH service docker image
========================


Description
-----------

This is ssh image based on Ubuntu 14.04 LTS docker image https://github.com/SylvainLasnier/ubuntu/  
SSH is note really usefull in production but could help to make some test


Usage
-----

User and password are 'root' word.

 **Tunnelling ssh service**:

Run on your host server:

    $ docker run -d --name ssh -p 22 sylvainlasnier/ssh
    $ docker ps
    CONTAINER ID        IMAGE                       COMMAND                CREATED             STATUS              PORTS                   NAMES
    6afb086d3ae9        sylvainlasnier/ssh:latest   /usr/bin/supervisord   3 seconds ago       Up 2 seconds        0.0.0.0:49153->22/tcp   dreamy_brattain
	
The mapping ssh docker port is 49153 in your host, for this example.  
Run on your local computer, to create ssh tunnel between your local computer and *Internet* - throw your server -:

    $ ssh -D2280  root@YOUR_SERVER_IP -p49153

Just declare proxy localhost:2280 to use this tunnel.


  **Ssh service for other Docker containers usage**:    
    
    $ docker inspect  -f '{{.NetworkSettings.IPAddress}}' `docker run -d --name ssh sylvainlasnier/ssh`
    172.17.0.4
    $ docker inspect  -f '{{.NetworkSettings.IPAddress}}' `docker run -d --name ssh2 sylvainlasnier/ssh`
    172.17.0.5
    $ docker ps
    CONTAINER ID        IMAGE                       COMMAND                CREATED             STATUS              PORTS               NAMES
    2906ec20ad16        sylvainlasnier/ssh:latest   /usr/bin/supervisord   3 seconds ago      Up 2 seconds       22/tcp               ssh2                  
	a2eb927638bd        sylvainlasnier/ssh:latest   /usr/bin/supervisord   5 seconds ago       Up 4 seconds        22/tcp              ssh                   
	
  	$ ssh root@172.17.0.4
 	root@a2eb927638bd:~# ssh 172.17.0.5
	root@2906ec20ad16:~#
	

And last but not least, you can build your own awesome VM based on this image.

I use these docker images in production and I assume update.
Have fun and try my other [docker images](https://hub.docker.com/u/sylvainlasnier/) ^^
