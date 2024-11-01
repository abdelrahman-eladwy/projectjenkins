pipeline {
    agent any  // Use any available Jenkins agent

    environment {
        IMAGE_NAME = 'eladwy/firstproject'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Clone the code repository from GitHub
                git branch: 'main', url: 'https://github.com/abdelrahman-eladwy/projectjenkins.git'
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

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerHub', 
                    passwordVariable: 'dockerHubPassword', 
                    usernameVariable: 'dockerHubUser')]) {
                    // Login to Docker Hub and push the image
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                    sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
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
            // Example email notification on success
            mail to: 'abdoahmed32522@gmail.com',
                 subject: "SUCCESS: Jenkins Job '${env.JOB_NAME}' (#${env.BUILD_NUMBER})",
                 body: "The build succeeded! Check Jenkins for details: ${env.BUILD_URL}"
        }
        failure {
            echo 'Build or deployment failed!'
            // Example email notification on failure
            mail to: 'abdoahmed32522@gmail.com',
                 subject: "FAILURE: Jenkins Job '${env.JOB_NAME}' (#${env.BUILD_NUMBER})",
                 body: "The build failed! Check Jenkins for details: ${env.BUILD_URL}"
        }
    }
}
