# Docker with Jenkins BlueOcean
A docker image to test BlueOcean along with Git and SCM plugins and able to run Docker containers inside

## Run

- run with `docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker -v /PATH/TO/REPO/workspace:/var/jenkins_home/workspace/ -p 8080:8080 --name blueocean ryanstockdale/jenkins-blueocean:latest`
- note the admin password dumped on log
- open a browser on [http://localhost:8080](http://localhost:8080/)
- run the initial setup wizard. Choose "recommended plugins"
- browse to <http://localhost:8080/blue>


## Git


To add a GitHub repo follow the wizard from the BlueOcean link in the left hand menu, You will be required to generate an Auth Key in GitHub. This will list all of your repos.

## Jenkinsfile

Jenkinsfile should be saved in root of repo

see https://jenkins.io/doc/book/pipeline/jenkinsfile/

EG **Jenkinsfile** 

	pipeline {
	  agent {
		docker {
		  image 'ryanstockdale/coldfusion2016-node-grunt'
		  args '-v $HOME:/var/working -v $HOME/.m2:/root/.m2 --user root'
		}
	  }
	  stages {
		stage('Test') {
		  steps {
			echo 'Testing..'
		  }
		}
	  }
	}