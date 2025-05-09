pipeline {
    agent any
    environment {
        IMAGE_NAME = (env.BRANCH_NAME == 'main') ? 'nodemain:v1.0' : 'nodedev:v1.0'
        HOST_PORT  = (env.BRANCH_NAME == 'main') ? '3000' : '3001'
        CONTAINER_PORT = '3000'
    }
    tools {
        nodejs 'NodeJS_18.20.8'
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
        stage('Cleanup Previous Containers') {
            steps {
                script {
                    def containerId = sh(script: "docker ps -q --filter ancestor=${IMAGE_NAME}", returnStdout: true).trim()
                    if (containerId) {
                        sh "docker stop ${containerId} && docker rm ${containerId}"
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                sh "docker run -d --expose ${HOST_PORT} -p ${HOST_PORT}:${CONTAINER_PORT} ${IMAGE_NAME}"
            }
        }
    }
}
