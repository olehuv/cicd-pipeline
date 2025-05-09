pipeline {
    agent any
    environment {
        APP_PORT = (env.BRANCH_NAME == 'main') ? '3000' : '3001'
        IMAGE_NAME = (env.BRANCH_NAME == 'main') ? 'nodemain:v1.0' : 'nodedev:v1.0'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                sh 'npm test'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }
        stage('Deploy') {
            steps {
                sh "docker run -d -p ${APP_PORT}:3000 ${IMAGE_NAME}"
            }
        }
    }
}
