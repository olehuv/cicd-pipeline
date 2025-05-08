pipeline {
    agent any

    environment {
        BRANCH_NAME = sh(script: 'git rev-parse --abbrev-ref HEAD', returnStdout: true).trim()
        PORT = BRANCH_NAME == 'main' ? '3000' : '3001'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo "Current branch: ${BRANCH_NAME}"
            }
        }

        stage('Change Logo') {
            steps {
                sh './scripts/change-logo.sh'
            }
        }

        stage('Build App') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }

        stage('Test App') {
            steps {
                sh 'npm test'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build --build-arg PORT=${PORT} -t my-app:${BRANCH_NAME} ."
            }
        }

        stage('Deploy') {
            steps {
                sh "docker stop my-app-${BRANCH_NAME} || true"
                sh "docker rm my-app-${BRANCH_NAME} || true"
                sh "docker run -d -p ${PORT}:${PORT} --name my-app-${BRANCH_NAME} my-app:${BRANCH_NAME}"
            }
        }
    }
}