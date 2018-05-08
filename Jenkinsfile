pipeline {
    node {
        def app

        parameters {
            artifactoryUrl(name:'Artifactory Url', description: 'URL for the artifactory repository where the image is going to be stored.')
        }

        stage('Clone repository') {
            /* Clone repository to our workspace */

            checkout scm
        }

        stage('Build image') {
            /* Build the docker image with the 
            * respective name */

            app = docker.build("${params.artifactoryUrl}/docker-local/rodrigocmn/docker-activemq:latest")
        }

        stage('Push image') {
            /* Push the image with two tags:
            * First, the incremental build number from Jenkins
            * Second, the 'latest' tag.
            * Pushing multiple tags is cheap, as all the layers are reused. */
            docker.withRegistry("http://${params.artifactoryUrl}", "jenkins-artifactory-credentials") {
                app.push("${env.BUILD_NUMBER}")
                app.push("latest")
                
            }
        }
    }
}