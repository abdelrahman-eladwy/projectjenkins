pipeline {
    agent any  // Use any available Jenkins agent

    environment {
        IMAGE_NAME = 'your-dockerhub-username/your-app'
        IMAGE_TAG = 'latest'
        DOCKER_REGISTRY_CREDENTIALS = 'docker-hub-credentials'  // Jenkins credential ID
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Clone the code repository from GitHub
                git branch: 'main', url: 'https://github.com/your-username/your-repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image from the Dockerfile
                    sh """
                        docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                    """
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub using credentials stored in Jenkins
                    withCredentials([usernamePassword(credentialsId: DOCKER_REGISTRY_CREDENTIALS, 
                            usernameVariable: 'DOCKER_USER', 
                            passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USER --password-stdin'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the built image to Docker Hub
                    sh """
                        docker push ${IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    // Run the Docker container from the pushed image
                    sh """
                        docker stop my-app || true && docker rm my-app || true
                        docker run -d --name my-app -p 80:80 ${IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image built, pushed, and deployed successfully!'
        }
        failure {
            echo 'Build or deployment failed!'
        }
    }
}
