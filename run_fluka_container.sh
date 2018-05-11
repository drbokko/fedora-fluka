docker run -i --rm --name fluka --net=host -e DISPLAY=192.168.0.100:0.0 -v ./docker_work:/docker_work -t my_fedora_27-fluka bash
