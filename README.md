# Broadview-Analytics-Docker
<p>This Dockerfile will build a working Broadcom Analytics Java VM container that you can run on a Linux PC.<br> 
This is useful so you don't have to install Java directly on a PC and if you are using multiple Collectors, this is a way to keep them from crushing each other.</p>

## To build:
```
git clone https://github.com/wililupy/Broadview-Anayltics-Docker.git
cd Broadview-Analytics-Docker
docker build -t bv-analytics-docker .
```
<p>This will download the openjdk:8 image from DockerHub and configure the container.<br>
Next it will install the dependancies for the GUI integration<br>
It then pulls the Broadcom-Analytics Java Applications from my fork from Broadcom.<br>
Lastly, it creates the volumes and environment variables and the entrypoint to start the Java VM.</p>

## Running the Container:
To run the container there are some prerequisites:
- A local `/pcap` directory to export PCAPs to
- A local `/switchdetails` folder so that in the even of an upgrade, you do not lose your switches be managed
- The X windows Display variable - Set to :0 by default, update the `Dockerfile` if this needs to be updated.
- Need to allow Docker access to the XHost:
  ```
  xhost +local:docker
  ```
- Next, run the following command to start the container:
  ```
  docker run --rm -d -p 8080:8080 -p 9070:9070 \
   -e DISPLAY=$DISPLAY \
   -v /tmp/.X11-unix:/tmp/.X11-unix \
   -v [local pcap dir]:/Broadview-Analytics/bin/pcap \
   -v [local switchdetails dir]:/Broadview-Analytics/bin/switchdetails \
   bv-analytics-docker
  ```
This will start the container in the background and start the Broadview Analytics Java Application.
  
