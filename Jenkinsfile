pipeline {
    agent any

    environment {
        VERSION = "v1"  // Starting with version v1
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
                bat "docker tag hello-world-docker thrishika/hello-world-docker:${VERSION}"
                echo "Tagged image with version: ${VERSION}"
            }
        }

        stage('Push Versioned Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    bat "docker login -u %DOCKER_USERNAME% -p %DOCKER_PASSWORD%"
                    bat "docker push thrishika/hello-world-docker:${VERSION}"
                }
            }
        }

        stage('Remove Old Container') {
            steps {
                bat 'docker rm -f hello-container || echo "No old container to remove"'
            }
        }

        stage('Run Specific Version of Image') {
            steps {
                bat "docker run -d --name hello-container thrishika/hello-world-docker:${VERSION}"
            }
        }
    }
}
