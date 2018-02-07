Instructions to run Fluka in a Docker Container under Fedora 27
========================================================
(by A. Fontana & V. Boccone, 06.02.2018)


# Installing docker 
You can install docker with your favourite package manager in linux.

The Docker website already provide wonderful installation instructions for the most common Linux flavours, Windows 10 and MacOS
[https://www.docker.com/community-edition#/download](https://www.docker.com/community-edition#/download)

Note: Docker in not anymore compatible with CentOS 6.x based system (RH6.x, Scientific Linux 6.x, etc...)

### Additional info for Linux
Once docker is installed you need to add your user to the docker group.   
```
sudo usermod -aG docker $USER
```

In this way, all docker commands can be issued as $USER.

# Generating your personal docker image with Fluka
The scripts for the generation of a basic Fluka-compatible image are open source.

### Download
You can download the latest version of the scripts from the github repository:   
[https://github.com/drbokko/fedora_27-fluka/archive/master.zip](https://github.com/drbokko/fedora_27-fluka/archive/master.zip)

### Checkout
You can alternatively checkout the full repository with the scripts from the github repository:   
```
boccone@Vittorios-iMac:~/Repositories: git clone https://github.com/drbokko/fedora_27-fluka
```

### Building the image
You can generate your personal Fluka image by running the ```BuildMe``` script in the root of the repository.
Note: in order to generate you personal Fluka image you need to provide an active fuid and password).
The installation might require a bit of time depending on the speed of your internet connection.
```
boccone@Vittorios-iMac:~/Repositories/fedora_27-fluka:[master *+]$ ./BuildMe 
Sending build context to Docker daemon  165.2MB
Step 1/11 : FROM drbokko/fedora_27-fluka
latest: Pulling from drbokko/fedora_27-fluka
a8ee583972c2: Downloading [=>                                                 ]  2.703MB/86.82MB
3545dcebf26c: Download complete 
93ad635dc92a: Downloading [>                                                  ]    528kB/157.7MB
9a3ef07fe690: Waiting 
0e0943e17c8a: Waiting 
7b1ab264a1fb: Waiting 
28a1f5892ffe: Waiting 
ffce54e6416f: Waiting 
c240375b746b: Waiting 

[...] 

COLLECT_GCC_OPTIONS='-msse2' '-mfpmath=sse' '-fPIC' '-O3' '-g' '-mtune=generic' '-fexpensive-optimizations' '-funroll-loops' '-Wall' '-Wuninitialized' '-Wno-tabs' '-Wline-truncation' '-Wno-unused-function' '-Wno-unused-parameter' '-Wno-unused-dummy-argument' '-Wno-unused-variable' '-Wunused-label' '-Waggregate-return' '-Wcast-align' '-Wsystem-headers' '-ftrapping-math' '-frange-check' '-fbackslash' '-fbacktrace' '-ffpe-trap=invalid,zero,overflow' '-finit-local-zero' '-ffixed-form' '-frecord-marker=4' '-funderscoring' '-fno-automatic' '-fd-lines-as-comments' '-fbounds-check' '-I' '/opt/fluka/flukapro' '-v' '-o' 'usbmax' '-L/opt/fluka' '-shared-libgcc' '-march=x86-64'
make[1]: Leaving directory '/opt/fluka/flutil'
Removing intermediate container 98a993cb3160
 ---> 71ac312f98d2
Successfully built 71ac312f98d2
Successfully tagged my_fedora_27-fluka:latest
boccone@Vittorios-iMac:~/Repositories/fedora_27-fluka:(master)$ 
```

During this phase the script will:
- download Fluka from [fluka.org](http://fluka.org) using your *fuid* and *password*;
- download the necessary base image from the docker hub to the local docker image repository;
- perform the necessary Fluka installation steps;
- create a *flukauser* default user in the image.


## Your first Fluka container 

### Creating a container
It is possible to get a shell terminal to container and to pass trough the X11 connection along with some local folder. 
This is done by issuing the following command:  
```
docker run -i --rm --name fluka --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -v $(pwd):/local_path -t my_fedora_27-fluka bash
```

Some info about the used options:
- the ```-i``` and ```-t``` options are required to get an interactive shell.
- the ```-v $(pwd):/local_path``` option create a shared pass through folder between the real system *pwd* and the folder ```/local_folder``` in the container. 
- the ```$(pwd)``` could be substituted by your home folder, or whatever folder you want to share with the container.
- the ```--name fluka``` will assing the name fluka to the running container.
Each container instance is identified by an unique CONTEINED ID code and an unique name. 
If no name is specified during the container creation docker will generate a random name.
- the ```--net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw"``` are for X11 forwarding

Note: Depending on your Xserver configuration you might need to run:
```
xhost + 
```
to enable the running the X11 forwarding.

### Using the container
Once in the docker container shell you could use the shell as if you would on a normal linux system.
You can try, for example,  to run Fluka by:
```
/home/flukauser/
mkdir test
cd test
cp -r /opt/fluka/example.inp .
$FLUPRO/flutil/rfluka -N0 -M1 example
```

### Working with containers
Each container instance is identified by an unique CONTEINED ID code and an unique name. 
If no name is specified during the container creation docker will generate a random name.

Once you finish working in your (interactive) container you can exit with the exit command.
If no ```--rm``` option is specified at the container instantiation all the modification will per saved for future sessions

For further session the docker container can be restarted with the 
CONTAINER ID code, obtained by:
```
docker ps -a
```

With the CONTAINER ID we can restart the Fluka session in Docker:
```
docker start CONTAINER ID
docker attach CONTAINER ID
```

