pipeline {
    agent {
        docker {
            image 'docker:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        PYTHON_ENV = '/usr/bin/python3'  // Adjust the Python path if needed
        DOCKER_IMAGE = 'dnmj/simple_python_app'  // Docker Hub repository name
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'  // Jenkins credentials ID for Docker Hub
    }

    stages {
        stage('Pull Docker Image') {
            steps {
                script {
                    // Pull the docker:latest image from Docker Hub
                    sh 'docker pull docker:latest'
                }
            }
        }

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/MaximeDYNA/simple_python_app.git' // Your repository URL
            }
        }

        stage('Install Dependencies') {
            steps {
                sh "${PYTHON_ENV} -m pip install --upgrade pip"
                sh "${PYTHON_ENV} -m pip install -r requirements.txt"
            }
        }

        stage('Run Tests') {
            steps {
                sh "${PYTHON_ENV} -m unittest discover"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image without sudo
                    sh "docker build -t ${DOCKER_IMAGE}:latest ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                    }
                    // Push the Docker image
                    sh "docker push ${DOCKER_IMAGE}:latest"
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                // Add your deployment steps here
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            cleanWs()
        }
    }
}
