current_dir = $(shell pwd)
export watson_DATADIR = $(current_dir)/watson/

#
.PHONY: dbuild drun drunb drunv dcon dstart dstop dvol dwats dcreate
dbuild: Dockerfile
	docker build --tag watson .

drun:
	docker run --name watson -it watson

drunb:
	docker run --name watson -it bash
	
drunv:
	docker run --name watson -it -v $(watson_DATADIR):/root/.config/watson/ watson

dcreate:
	#docker create -it --name new-container watson
	docker create --name watson -it -v $(watson_DATADIR):/root/.config/watson/ watson

dcon:
	docker start watson
	docker exec -it watson bash

dwats:
	docker exec -it watson watson

dstart:
	source ./watson.sh && docker start watson
	#source $(current_dir)/watson.sh
	#$(current_dir)/watson.sh

dstop:
	docker stop watson

# This is where Docker stores volumes on the host
dvol:
	screen ~/Library/Containers/com.docker.docker/Data/vms/0/tty
	#screen /Users/sklikizos/Library/Containers/com.docker.docker/Data/vms/0/tty

dtest:
	echo $(watson_DATADIR)