pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = 'gauravsadhwani'  // Replace with your Docker Hub username
        DOCKERHUB_REPO = 'gaurav_assessment'    // Replace with your Docker Hub repository name
        DOCKER_IMAGE_TAG = "${DOCKERHUB_USERNAME}/${DOCKERHUB_REPO}:latest"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // Install dependencies (Node.js)
                    sh 'npm install app/'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image and tag it
                    sh "docker build -t ${DOCKER_IMAGE_TAG} ."
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                        // Push the Docker image to Docker Hub
                        sh "docker push ${DOCKER_IMAGE_TAG}"
                    }
                }
            }
        }

    post {
        always {
            echo 'Cleaning up...'
            sh 'docker rmi ${DOCKER_IMAGE_TAG} || true'  // Clean up the Docker image from Jenkins agent
        }
    }
}
