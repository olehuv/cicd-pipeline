pipeline {
    agent any
    environment {
        BRANCH_NAME = "${env.BRANCH_NAME}"
        APP_PORT = (env.BRANCH_NAME == 'main') ? '3000' : '3001'
        IMAGE_NAME = (env.BRANCH_NAME == 'main') ? 'nodemain:v1.0' : 'nodedev:v1.0'
    }
    parameters {
        string(name: 'DEPLOY_BRANCH', defaultValue: 'main', description: 'Branch to deploy')
    }
    stages {
        stage('Manual Approval') {
            steps {
                input message: "Deploy ${params.DEPLOY_BRANCH}?", ok: 'Deploy'
            }
        }
        stage('Checkout') {
            steps {
                git branch: "${params.DEPLOY_BRANCH}", url: 'git@your-repo.git'
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
