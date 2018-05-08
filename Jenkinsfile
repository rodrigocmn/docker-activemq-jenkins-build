pipeline {
  agent any
  parameters {
    string( name: 'artifactoryUrl', 
            defaultValue: 'artifactory:8087', 
            description: 'Artifactory repository URL (server:port).')
    string( name: 'repositoryPath', 
            defaultValue: 'docker-local/rodrigocmn/docker-activemq/', 
            description: 'Path to the respository in Artifactory (i.e. docker-local/projectname/docker-app/).')
  }
  stages {
    stage('Clone repository') {
      steps {
        checkout scm
        script {
          def app
        }

      }
    }
    stage('Build image') {
      steps {
        script {
          app = docker.build("${params.artifactoryUrl}/docker-local/rodrigocmn/docker-activemq:latest")
        }

      }
    }
    stage('Push image') {
      steps {
        script {
          docker.withRegistry("http://${params.artifactoryUrl}", "jenkins-artifactory-credentials") {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
          }
        }

      }
    }
  }
}