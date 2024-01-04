pipeline {

  environment {
    dockerimagename = "cafanwii/httpd-documentation"
    dockerImage = ""
  }

  agent {
        docker {
            image 'docker:20.10.0' // Specify a Docker image with Docker CLI installed
            registryUrl 'https://registry.hub.docker.com' // Adjust this based on your registry URL
            registryCredentialsId 'cafanwii'
        }
    }

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/cafanwi/jenkins-kubernetes-deployment.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'cafanwii'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
    }

    stage('Deploying doc container to Kubernetes') {
      steps {
        script {
          kubernetesDeploy(configs: "deploy.yaml", "svc.yaml")
        }
      }
    }

  }

}
