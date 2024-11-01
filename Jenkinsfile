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

       
           stage('Ansible Build, Push, and Deploy') {
            steps {
                // Inject Docker Hub credentials and run Ansible playbook
                withCredentials([usernamePassword(credentialsId: 'dockerHub', 
                    passwordVariable: 'dockerHubPassword', 
                    usernameVariable: 'dockerHubUser')])  {
                    ansiblePlaybook(
                        playbook: 'deploy.yml',
                        inventory: 'inventory.ini' 
                    )
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
