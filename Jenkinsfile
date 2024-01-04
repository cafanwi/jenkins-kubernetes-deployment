pipeline {

  environment {
    dockerimagename = "cafanwii/httpd-documentation"
    dockerImage = ""
  }

  agent any

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
               registryCredential = 'cafanwii-docker'
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