Instructions to run Fluka in a Fedora 27 Docker Container 
========================================================
A. Fontana, V. Boccone

# Installing docker 
You can install Docker in the host OS by following the instructions 
on the Docker website: these are available for the most common Linux 
flavours, Windows 10 (Home and Professional Editions) and MacOS.

### OS X, Linux, Windows 10 Pro, Enterprise, and Education

Install Docker Community Edition:
https://www.docker.com/community-edition

### Windows 10 Home (and possibly older Windows versions)

Install Docker Toolbox: https://www.docker.com/products/docker-toolbox

Windows 10 Home does not enable hyper-v, which is required for Docker Community Edition. 
Docker Toolbox provides a workaround. This is not optimal for performance, but it allows 
to run FLUKA also on Windows 10 Home.

### Post installation steps for both Windows 10 versions

# Enable powershell scripts execution
# Allow Docker through the firewall
# Start Xming (http://www.straightrunning.com/XmingNotes/) without access control

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

### OS X, Linux

You can generate your personal Fluka image by running in a terminal the ```build_linux_dockerFLUKA.sh``` script in the root of the repository.
Note: in order to generate you personal Fluka image you need to provide an active fuid and password).
The installation might require a bit of time - from 1 to 10 minutes - depending on the speed of your internet connection.

### Windows 10 Pro, Enterprise, and Education

Create the directory C:\docker, start a powershell prompt in C:\docker and execute ```build_win_dockerFLUKA.ps1```
This script will prompt for your FLUKA credentials (fuid-xxxx and password), download the latest public FLUKA release and install it in a Fedora 27 based Docker container.
Then execute ```run_win_dockerFLUKA.ps1```: this script will start the Docker container with FLUKA and FLAIR installed.

### Windows 10 Home (and possibly older Windows versions)

Create the directory C:\Users\docker, start a powershell prompt in C:\Users\docker (mandatory!) and execute ```build_win_dockerFLUKA.ps1```
This script will prompt for your FLUKA credentials (fuid-xxxx and password), download the latest public FLUKA release and install it in a Fedora 27 based Docker container.
Start as Administrator a Docker Quickstart Terminal and execute from /c/Users/docker
```run_win_home_dockerFLUKA.sh```: this script will start the Docker container with FLUKA and FLAIR installed and ready to be used.

The typical output of this step is as follows:
```
boccone@Vittorios-iMac:~/Repositories/fedora_27-fluka:(master)$ ./build_fluka_container.sh 
Downloading Fluka
Please specify your Fluka user identification ('fuid', i.e. fuid-1234)
fuid: fuid-XXXX
Password for user 'fuid-XXXX': 
--2018-02-07 21:30:15--  https://www.fluka.org/packages/fluka2011.2c-linux-gfor64bitAA.tar.gz
Resolving www.fluka.org... 193.205.78.76
Connecting to www.fluka.org|193.205.78.76|:443... connected.
HTTP request sent, awaiting response... 401 Authorization Required
Authentication selected: Basic realm="FLUKA download interface"
Connecting to www.fluka.org|193.205.78.76|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 164993043 (157M) [application/x-gzip]
Saving to: 'fluka2011.2c-linux-gfor64bitAA.tar.gz'

fluka2011.2c-linux-gfor64bitAA.tar.gz                       100%[=========================================================================================================================================>] 157.35M   486KB/s    in 4m 48s  

2018-02-07 21:35:03 (560 KB/s) - 'fluka2011.2c-linux-gfor64bitAA.tar.gz' saved [164993043/164993043]
                                                                                                                                 ]   7.88M   611KB/s    eta 4m 17s 
Sending build context to Docker daemon  165.2MB
Step 1/11 : FROM drbokko/fedora_27-fluka
latest: Pulling from drbokko/fedora_27-fluka
a8ee583972c2: Pull complete 
3545dcebf26c: Pull complete 
93ad635dc92a: Pull complete 
9a3ef07fe690: Pull complete 
0e0943e17c8a: Pull complete 
7b1ab264a1fb: Pull complete 
28a1f5892ffe: Pull complete 
ffce54e6416f: Pull complete 
c240375b746b: Pull complete 
Digest: sha256:fad5622b80442187bf662193da7f721ac1f87dccb8fc7298180fe8cc393a38f9
Status: Downloaded newer image for drbokko/fedora_27-fluka:latest
 ---> dac526ea8539
Step 2/11 : RUN useradd fluka
 ---> Running in a66543fc8e12
Removing intermediate container a66543fc8e12
 ---> a1006aff563f
Step 3/11 : ENV LOGNAME=flukauser
 ---> Running in 03240be9ea4b
Removing intermediate container 03240be9ea4b
 ---> 0bb59a4558b5
Step 4/11 : ENV USER=flukauser
 ---> Running in 65e515d4c3e6
Removing intermediate container 65e515d4c3e6
 ---> 1af325423280
Step 5/11 : RUN mkdir -p /opt/fluka
 ---> Running in 80612902d587
Removing intermediate container 80612902d587
 ---> 44242941c214
Step 6/11 : RUN chown -R fluka:fluka /opt/fluka
 ---> Running in 4b4497cd828a
Removing intermediate container 4b4497cd828a
 ---> 4bedf075d6d1
Step 7/11 : ENV FLUFOR=gfortran
 ---> Running in 2b271a6f6b9e
Removing intermediate container 2b271a6f6b9e
 ---> 80fedf17c4d6
Step 8/11 : ENV FLUPRO=/opt/fluka
 ---> Running in 870e23f7b01b
Removing intermediate container 870e23f7b01b
 ---> 2b13352b074b
Step 9/11 : COPY *.tar.gz /tmp
 ---> f455a18971dc
Step 10/11 : RUN tar -zxvf /tmp/*.tar.gz -C /opt/fluka
 ---> Running in f26404616586
sigmapi.bin
elasct.bin
nuclear.bin
fluodt.dat
neuxsc-ind_260.bin
brems_fin.bin

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

### OS X Linux
It is possible to get a shell terminal to container and to pass trough the X11 connection along with some local folder. 
Execute from a terminal ```run_linux_dockerFLUKA.sh```: this script will start the Docker container with FLUKA and FLAIR installed.

### Windows 10 Pro, Enterprise, and Education

Execute from a powershell prompt ```run_win_dockerFLUKA.ps1```: this script will start the Docker container with FLUKA and FLAIR installed.

### Windows 10 Home (and possibly older Windows versions)

Start as Administrator a Docker Quickstart Terminal and execute from /c/Users/docker
```run_win_home_dockerFLUKA.sh```: this script will start the Docker container with FLUKA and FLAIR installed and ready to be used.

Some info about the Docker options used in these scripts:
- the ```-i``` and ```-t``` options are required to get an interactive shell;
- the ```-v $(pwd):/shared_path``` option create a shared pass through folder between the real system *pwd* and the folder ```/shared_folder``` in the container; 
- the ```$(pwd)``` could be substituted by your home folder, or whatever folder you want to share with the container;
- the ```--rm``` option will destroy the contained upon exit. All the local modification ();
- the ```--name fluka``` will assing the name fluka to the running container.
Each container instance is identified by an unique CONTAINER ID code and an unique name. 
If no name is specified during the container creation docker will generate a random name;
- the ```--net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw"``` are for X11 forwarding.

Note: Depending on your Xserver configuration you might need to run:
```
xhost + 
```
to enable the running the X11 forwarding.

### Using the container
Once in the docker container shell you could use the shell as if you would on a normal linux system.
You can try, for example, to run Fluka by:
```
[flukauser@linuxkit-025000000001 ~]$ mkdir test
[flukauser@linuxkit-025000000001 ~]$ cd test
[flukauser@linuxkit-025000000001 test]$ cp -r /opt/fluka/example.inp .
[flukauser@linuxkit-025000000001 test]$ $FLUPRO/flutil/rfluka -N0 -M1 example
$TARGET_MACHINE = Linux
$FLUPRO = /opt/fluka

Initial seed copied from /opt/fluka
Running fluka in /home/flukauser/test/fluka_25

======================= Running FLUKA for cycle # 1 =======================

Removing links
Removing temporary files
Saving output and random number seed
Saving additional files generated
     Moving fort.47 to /home/flukauser/test/example001_fort.47
     Moving fort.48 to /home/flukauser/test/example001_fort.48
     Moving fort.49 to /home/flukauser/test/example001_fort.49
     Moving fort.50 to /home/flukauser/test/example001_fort.50
     Moving fort.51 to /home/flukauser/test/example001_fort.51
End of FLUKA run
```

or also running Flair.

### Working with containers
Working with containers might not be so easy if are not used to the Command Line Interface in Linux. [Digital Ocean provides a nice primer [link here]](https://www.digitalocean.com/community/tutorials/working-with-docker-containers) 

Each container instance is identified by an unique CONTAINER ID code and an unique name. 
If no name is specified during the container creation docker will generate a random name.

If you are working in an interactive container you can terminate the shell by typing exit.
If no ```--rm``` option was specified at the container instantiation the status container will not be lost and will besaved on the system.

The list of the instantiated container (and their status) can be obtained by the following command:
```
docker ps -a
```

An *Exited* container can be restarted with:
```
docker start <CONTAINER ID> or <CONTAINER NAME>
```

An *Running* but detached container can be reattached by:
```
docker attach <CONTAINER ID> or <CONTAINER NAME>
```

