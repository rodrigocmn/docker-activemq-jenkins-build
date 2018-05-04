node {
    def app

    stage('Clone repository') {
        /* Clone repository to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* Build the docker image with the 
         * respective name */

        app = docker.build("artifactory:8087/docker-local/rodrigocmn/docker-activemq:latest")
    }

    stage('Push image') {
        /* Push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('http://artifactory:8087', 'jenkins-artifactory-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}