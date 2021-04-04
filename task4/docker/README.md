## Info:
* My flask-app run in docker
* Used small alpine-python from hub.docker.com
* I was update pip and use venv (it is not necessary but i do it just for example)
* The working image has a size of ~~*129 MB*~~ ~~*65,3 MB *~~ 64.4 MB.

## Requirements
* any Linux OS
* connection with Internet network
* bash
* docker

# How it start
* Just run the script in the application directory "sudo bash start.sh"
* If you want - you can change build parameters in Dockerfile
* Required components are listed in the file requirements.txt (flask and emoji)
* After building and starting the container, the application responds to requests like
* "curl -XPOST -d'{"word":"cat", "count": 5}' http://192.168.0.50:1080"

