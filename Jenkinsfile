pipeline {
    agent any
    environment {
        IMAGE_NAME = "thrishika/hello-world-docker"
        DOCKER_CREDENTIALS_ID = "docker-hub-creds"
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
                    def versionFile = readFile('version.txt').trim()
                    echo "🔢 Current version: ${versionFile}"

                    def versionNum = versionFile.replaceAll("[^0-9]", "").toInteger()
                    def newVersionNum = versionNum + 1
                    newVersion = "v${newVersionNum}"
                    echo "🚀 New version: ${newVersion}"

                    // Save back to version.txt
                    writeFile file: 'version.txt', text: newVersion

                    // Commit updated version.txt to GitHub
                    bat "git config user.email \"you@example.com\""
                    bat "git config user.name \"jenkins\""
                    bat "git add version.txt"
                    bat "git commit -m \"🔁 Auto bump to ${newVersion}\""
                    bat "git push origin main"
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
                bat "docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:${newVersion}"
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat "docker login -u %DOCKER_USER% -p %DOCKER_PASS%"
                    bat "docker push ${IMAGE_NAME}:${newVersion}"
                }
            }
        }
    }
}
