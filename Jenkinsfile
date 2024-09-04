pipeline {
    agent any

    environment {
        // Specify the Python path directly
        PYTHON_ENV = '/usr/bin/python3'  // or the full path to Python on your system
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/MaximeDYNA/simple_python_app.git' // Replace with your repository URL
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
