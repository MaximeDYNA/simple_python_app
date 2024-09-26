pipeline {
    agent {
        docker {
            image 'docker:latest'  // Image avec Python préinstallé
            args '-u root -v /var/run/docker.sock:/var/run/docker.sock'  // Docker-in-Docker
        }
    }

    environment {
        PYTHON_ENV = '/usr/bin/python3'  // Python est dans le PATH dans l'image python:3.8-slim
        DOCKER_IMAGE = 'dnmj/simple_python_app'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
    }

    stage('Pull Docker Image') {
            steps {
                script {
                    // Ensure Docker is available and pull the docker image
                    sh 'docker --version'  // Check if Docker is installed
                    sh 'docker pull docker:latest'
                }
            }
        }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/MaximeDYNA/simple_python_app.git'  // Votre dépôt GitHub
            }
        }

        stage('Install Dependencies') {
            steps {
                sh "${PYTHON_ENV} -m pip install --upgrade pip"
                sh "${PYTHON_ENV} -m pip install --no-cache-dir -r requirements.txt"
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
                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE}:latest ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub and push the image
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                    }
                    sh "docker push ${DOCKER_IMAGE}:latest"
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                // Ajoutez ici les étapes de déploiement
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
