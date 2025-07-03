pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'hello-world-docker'
        DOCKER_USER = 'thrishika'
        VERSION_TAG = "v${env.BUILD_NUMBER}"
    }

    stages {
        stage('Clone GitHub Repo') {
            steps {
                git url: 'https://github.com/thrishi0610/hello_word_jenkin.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Tag Image with Version') {
            steps {
                bat "docker tag ${DOCKER_IMAGE} ${DOCKER_USER}/${DOCKER_IMAGE}:${VERSION_TAG}"
                echo "Tagged image with version: ${VERSION_TAG}"
            }
        }

        stage('Push Versioned Docker Image') {
            steps {
                withCredentials([string(credentialsId: 'docker-pass', variable: 'DOCKER_PASS')]) {
                    bat "echo %DOCKER_PASS% | docker login -u ${DOCKER_USER} --password-stdin"
                    bat "docker push ${DOCKER_USER}/${DOCKER_IMAGE}:${VERSION_TAG}"
                }
            }
        }

        stage('Remove Old Container') {
            steps {
                bat 'docker stop hello-container || exit 0'
                bat 'docker rm hello-container || exit 0'
            }
        }

        stage('Run Specific Version of Image') {
            steps {
                bat "docker pull ${DOCKER_USER}/${DOCKER_IMAGE}:${VERSION_TAG}"
                bat "docker run -d -p 8000:8000 --name hello-container ${DOCKER_USER}/${DOCKER_IMAGE}:${VERSION_TAG}"
            }
        }
    }
}
