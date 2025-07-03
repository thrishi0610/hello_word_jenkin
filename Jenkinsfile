pipeline {
    agent any

    environment {
        IMAGE_NAME = "hello-world-docker"
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-creds')
    }

    stages {
        stage('Clone GitHub Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/thrishi0610/hello_word_jenkin.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Tag Image with Version') {
            steps {
                script {
                    def commitHash = bat(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                    def versionTag = "v${commitHash}"
                    echo "✔ Tagging image as thrishika/${IMAGE_NAME}:${versionTag}"
                    bat "docker tag ${IMAGE_NAME} thrishika/${IMAGE_NAME}:${versionTag}"
                    env.VERSION_TAG = versionTag  // Store for next stage
                }
            }
        }

        stage('Push Versioned Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    bat "docker login -u %DOCKER_USERNAME% -p %DOCKER_PASSWORD%"
                    bat "docker push thrishika/${IMAGE_NAME}:${env.VERSION_TAG}"
                }
            }
        }

        stage('Remove Old Container') {
            steps {
                bat 'docker stop running-container || echo No container to stop'
                bat 'docker rm running-container || echo No container to remove'
            }
        }

        stage('Run Specific Version of Image') {
            steps {
                bat "docker run -d --name running-container -p 8000:8000 thrishika/${IMAGE_NAME}:${env.VERSION_TAG}"
            }
        }
    }
}
