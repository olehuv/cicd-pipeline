pipeline {
    agent any

    tools {
        nodejs 'NodeJS 23'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Set Environment Variables') {
            steps {
                script {
                    if (BRANCH_NAME == 'main') {
                        env.PORT = '3000'
                        env.IMAGE_TAG = 'nodemain:v1.0'
                        env.LOGO_FILE = 'logo_main.svg'
                    } else if (BRANCH_NAME == 'dev') {
                        env.PORT = '3001'
                        env.IMAGE_TAG = 'nodedev:v1.0'
                        env.LOGO_FILE = 'logo_dev.svg'
                    } else {
                        error "Unsupported branch: ${BRANCH_NAME}"
                    }
                    println "Building for branch: ${BRANCH_NAME} with port: ${env.PORT} and image tag: ${env.IMAGE_TAG}"
                }
            }
        }

        stage('Copy Logo') {
            steps {
                sh "cp ${env.LOGO_FILE} logo.svg"
            }
        }

        stage('Build') {
            steps {
                sh 'node --version'
                sh 'npm --version'
                //sh 'npm install'
                sh './scripts/build.sh'
            }
        }

        stage('Test') {
            steps {
                sh './scripts/test.sh'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build(env.IMAGE_TAG)
                }
            }
        }

        stage('Deploy') {
            steps {
                input message: "Approve deployment of ${env.IMAGE_TAG} from branch ${BRANCH_NAME}"
                script {
                    docker.withRegistry('', '') { //Docker Registry
                        dockerImage.push()
                    }
                    // Додайте сюди команди для розгортання вашого Docker контейнера
                    // Наприклад:
                    // sh "docker run -d -p ${env.PORT}:${env.PORT} --name myapp ${env.IMAGE_TAG}"
                    println "Deployment of ${env.IMAGE_TAG} from branch ${BRANCH_NAME} initiated on port ${env.PORT}"
                }
            }
        }
    }
}
