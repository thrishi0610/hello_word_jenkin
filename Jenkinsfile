pipeline {
    agent any

    environment {
        IMAGE_NAME = "thrishika/hello-world-docker"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Read & Increment Version') {
            steps {
                script {
                    def versionFile = 'version.txt'
                    def currentVersion = readFile(versionFile).trim()
                    echo "🔢 Current version: ${currentVersion}"

                    def versionNumber = currentVersion.replace("v", "").toInteger()
                    def newVersion = "v${versionNumber + 1}"
                    echo "🚀 New version: ${newVersion}"

                    writeFile file: versionFile, text: "${newVersion}"

                    bat 'git config user.email "you@example.com"'
                    bat 'git config user.name "jenkins"'
                    bat 'git add version.txt'
                    bat 'git commit -m "🔁 Auto bump to ${newVersion}"'
                    bat 'git checkout main'
                    bat 'git push origin main'

                    env.NEW_VERSION = newVersion
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Tag Docker Image with Version') {
            steps {
                bat "docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:${env.NEW_VERSION}"
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'DOCKER_HUB_CREDENTIALS', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    bat 'echo %PASSWORD% | docker login -u %USERNAME% --password-stdin'
                    bat "docker push ${IMAGE_NAME}:${env.NEW_VERSION}"
                    bat "docker push ${IMAGE_NAME}:latest"
                }
            }
        }
    }
}
