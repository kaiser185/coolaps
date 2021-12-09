###
# COOLAPS v 0.0.4 build system
###
DATA=data
WORKDIR=/root
VERSION=latest
#Feel free to change the organization identifier
#if you also decide to change the container name
#make sure you also change the PS variable set
#below, or several of the commands will not work
COOLAPS=coolaps/coolaps:$(VERSION)
PORTS=8081:8081
## If you want to have access to local data in you container you must mount the
## volume with the following line, making sure that you have a 
##<base_app_folder>/data folder with your desired files
## Otherwise leave DOCKERMOUNT set to the empty string
#DOCKERMOUNT= -v $(PWD)/$(DATA):$(WORKDIR)/$(DATA)
DOCKERMOUNT=
DOCKEROPTS=  -t -d -p $(PORTS)
DOCKERCOMMAND= run $(DOCKEROPTS) $(DOCKERMOUNT) $(COOLAPS)
ATTACHOPTS=  -i -t -p $(PORTS)
ATTACHCOMMAND= run $(ATTACHOPTS) $(DOCKERMOUNT) $(COOLAPS)
PS := $(shell docker ps | grep coolaps | cut -d " " -f1)

.PHONY: all run ba nba exec cid stop clean

# Just build the docker image
all: 
	docker build -t $(COOLAPS) .

# Just run the docker image
run:
	docker $(DOCKERCOMMAND)

# Build and then run the image and attach to the container
ba: clean all
	docker $(ATTACHCOMMAND)

# Justun the image and attach to the container
nba:
	docker $(ATTACHCOMMAND)

# Get an interactive terminal on the container
exec:
	docker exec -it $(PS) /bin/bash

# Hook into the tool's Logfile to observe its behavior
tail:
	docker exec -it $(PS) tail -f /root/httpd.log

# Get the tool's process id
cid:
	@echo $(PS)

# stop the container when detached
stop:
	docker stop -t 0 $(PS)

# clean the docker environment
clean:
	docker container prune -f
	docker image prune -f
	docker volume prune -f
