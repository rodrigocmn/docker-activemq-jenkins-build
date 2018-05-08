pipeline {
  agent any
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
  parameters {
    string(name: 'artifactoryUrl', defaultValue: 'artifactory:8087', description: 'Artifactory repository URL (server:port).')
  }
}