pipeline {
    agent any

    tools {
            nodejs 'node18.20.8'
        }

    environment {
        NODE_ENV = 'production'
    }

    stages {
        stage('Prepare Environment Variables') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'main') {
                        env.HOST_PORT = '3000'
                        env.IMAGE_NAME = 'nodemain:v1.0'
                    } else {
                        env.HOST_PORT = '3001'
                        env.IMAGE_NAME = 'nodedev:v1.0'
                    }
                }
            }
        }

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
                script {
                    // Зупинка контейнера з таким образом (якщо існує)
                    sh "docker ps -q --filter ancestor=${IMAGE_NAME} | xargs -r docker stop"
                    sh "docker ps -a -q --filter ancestor=${IMAGE_NAME} | xargs -r docker rm"

                    // Запуск нового контейнера
                    sh "docker run -d --expose 3000 -p ${HOST_PORT}:3000 ${IMAGE_NAME}"
                }
            }
        }
    }
}
