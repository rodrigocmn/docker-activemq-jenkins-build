# Active MQ

This solution delivers a container implementation the [ActiveMQ Shared File System Master Slave](http://activemq.apache.org/shared-file-system-master-slave.html) configuration. 

## Configuration files

All the configuration files are stored under the folder 'config'. These are the current configuration files used in this solution:

* activemq.xml - 


## Dockerfile

The dockerfile is currently performing the following steps:

* Configuring the application settings
* Installing ActiveMQ pre-requisites
* Installing ActiveMQ
* Copying ActiveMQ configuration files to the respective folder inside the image
* Adjusting folders permissions
* Configuring what ActiveMQ ports are going to be exposed
* Mapping volumes to docker host
* Defining working folder and start command for ActiveMQ




