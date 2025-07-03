pipeline {
    agent any

    environment {
        IMAGE_NAME = "thrishika/hello-world-docker"
        VERSION = "v${BUILD_NUMBER}"
    }

    stages {
        stage('Clone GitHub Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/thrishi0610/hello_word_jenkin.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t hello-world-docker ."
            }
        }

        stage('Tag Image with Version') {
            steps {
                bat "docker tag hello-world-docker ${IMAGE_NAME}:${VERSION}"
                echo "Tagged image with version: ${VERSION}"
            }
        }

        stage('Push Versioned Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    bat "docker login -u %DOCKER_USERNAME% -p %DOCKER_PASSWORD%"
                    bat "docker push ${IMAGE_NAME}:${VERSION}"
                }
            }
        }

        stage('Remove Old Container') {
            steps {
                bat """
                    docker stop running-container || echo No container to stop
                    docker rm running-container || echo No container to remove
                """
            }
        }

        stage('Run Specific Version of Image') {
            steps {
                bat "docker run -d -p 8000:8000 --name running-container ${IMAGE_NAME}:${VERSION}"
            }
        }
    }
}
