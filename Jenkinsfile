pipeline {
  agent any
  parameters {
    string( name: 'artifactoryUrl', 
            defaultValue: '10.151.197.4:8081', 
            description: 'Artifactory repository URL (server:port).')
    string( name: 'repositoryPath', 
            defaultValue: 'epos-docker-local/jenkins/docker-activemq', 
            description: 'Path to the respository in Artifactory (i.e. docker-local/projectname/docker-app/).')
    string( name: 'repositoryCredentials', 
            defaultValue: 'jenkins-artifactory-credentials', 
            description: 'Jenkins credentials identification for the target Artifactory repository.')
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
          app = docker.build("${params.artifactoryUrl}/${params.repositoryPath}:latest")
        }

      }
    }
    stage('Push image') {
      steps {
        script {
          docker.withRegistry("http://${params.artifactoryUrl}", "${params.repositoryCredentials}") {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
          }
        }

      }
    }
  }
}