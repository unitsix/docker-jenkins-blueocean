FROM jenkins/jenkins:latest
 
USER root

RUN apt-get update \
      && apt-get install -y --no-install-recommends apt-utils \
      && DEBIAN_FRONTEND=noninteractive apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*
	  
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN DEBIAN_FRONTEND=noninteractive curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz \
  && sudo usermod -a -G root jenkins
 
USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN xargs /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt

# docker build -f Dockerfile . -t jenkins:blueocean
# docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker -v /PATH/TO/REPO/workspace:/var/jenkins_home/workspace/ -p 8085:8080 --name jenkins jenkins:blueocean 