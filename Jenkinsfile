pipeline {
    agent {
        docker {
            image 'docker:latest'  // Image avec Docker
            args '-u root -v /var/run/docker.sock:/var/run/docker.sock'  // Docker-in-Docker
        }
    }

    environment {
        PYTHON_ENV = '/usr/bin/python3'  // Chemin vers Python
        DOCKER_IMAGE = 'dnmj/simple_python_app'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
    }

    stages {
        stage('Pull Docker Image') {
            steps {
                script {
                    catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
                        // Vérifie si Docker est installé et tire l'image
                        sh 'docker --version'  // Vérifie si Docker est installé
                        sh 'docker pull docker:latest'
                    }
                }
            }
        }

        stage('Checkout') {
            steps {
                script {
                    catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
                        git branch: 'main', url: 'https://github.com/MaximeDYNA/simple_python_app.git'  // Votre dépôt GitHub
                    }
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
                        sh "${PYTHON_ENV} -m pip install --upgrade pip"
                        sh "${PYTHON_ENV} -m pip install --no-cache-dir -r requirements.txt"
                    }
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
                        sh "${PYTHON_ENV} -m unittest discover"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
                        // Construire l'image Docker
                        sh "docker build -t ${DOCKER_IMAGE}:latest ."
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
                        // Connexion à Docker Hub et envoi de l'image
                        withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                            sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                        }
                        sh "docker push ${DOCKER_IMAGE}:latest"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
                        echo 'Deploying the application...'
                        // Ajoutez ici les étapes de déploiement
                    }
                }
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
