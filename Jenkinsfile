pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = 'gauravsadhwani'  // Replace with your Docker Hub username
        DOCKERHUB_REPO = 'gaurav_assessment'    // Replace with your Docker Hub repository name
        DOCKER_IMAGE_TAG = "${DOCKERHUB_USERNAME}/${DOCKERHUB_REPO}:latest"
        K8S_DEPLOYMENT_YAML = 'k8s-deployment.yaml' // Replace with your Kubernetes deployment name
        KUBERNETES_NAMESPACE = 'default'     
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
                    sh 'npm install myapp/'
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
                    // Use credentials stored in Jenkins for Docker login
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        // Login to Docker Hub
                        sh "echo ${DOCKERHUB_PASSWORD} | docker login -u ${DOCKERHUB_USERNAME} --password-stdin"
                        // Push the Docker image
                        sh "docker push ${DOCKER_IMAGE_TAG}"
                }
            }
        }
    }
        stage('Deploy to EKS') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    script {
                        // Ensure kubectl is configured to access your EKS cluster
                        sh '''
                        aws eks update-kubeconfig --name "gaurav-assessment-eks" --region "eu-central-1"
                        kubectl apply -f ${K8S_DEPLOYMENT_YAML} -n ${KUBERNETES_NAMESPACE}
                        '''
                    
                        // Verify deployment
                        sh '''
                        kubectl rollout status deployment/hello-world -n ${KUBERNETES_NAMESPACE}
                        '''
                    }
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
