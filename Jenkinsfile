pipeline {
    agent any
    

    parameters {
        string(name: 'artifactoryUrl', defaultValue: 'artifactory:8087', description: 'Artifactory repository URL (server:port).')
    }

    stages{
        
        stage('Clone repository') {
            /* Clone repository to our workspace */
            steps{
                checkout scm
                script{
                    def app
                }
                
            }
            
        }

        stage('Build image') {
            /* Build the docker image with the 
            * respective name */
            steps {
                script{
                    app = docker.build("${params.artifactoryUrl}/docker-local/rodrigocmn/docker-activemq:latest")
                }
            }
            
        }

        stage('Push image') {
            /* Push the image with two tags:
            * First, the incremental build number from Jenkins
            * Second, the 'latest' tag.
            * Pushing multiple tags is cheap, as all the layers are reused. */
            
            steps{
                script{
                    docker.withRegistry("http://${params.artifactoryUrl}", "jenkins-artifactory-credentials") {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                }
            }
                
            }
        }
    }
}