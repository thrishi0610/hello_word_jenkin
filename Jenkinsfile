pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = credentials('docker-hub-creds') // Your DockerHub creds ID
        IMAGE_NAME = 'thrishika/hello-world-docker'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/thrishi0610/hello_word_jenkin.git'
            }
        }

        stage('Read & Increment Version') {
            steps {
                script {
                    def versionFile = 'version.txt'
                    def currentVersion = readFile(versionFile).trim()
                    echo "🔢 Current version: ${currentVersion}"

                    def versionNumber = currentVersion.replaceAll("[^0-9]", "").toInteger()
                    def newVersion = "v${versionNumber + 1}"
                    echo "🚀 New version: ${newVersion}"

                    writeFile file: versionFile, text: newVersion

                    bat "git config user.email \"you@example.com\""
                    bat "git config user.name \"jenkins\""
                    bat "git add ${versionFile}"
                    bat "git commit -m \"🔁 Auto bump to ${newVersion}\""
                    bat "git push origin HEAD:main"

                    env.IMAGE_TAG = newVersion
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t ${IMAGE_NAME}:${env.IMAGE_TAG} ."
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    bat "docker login -u ${DOCKER_CREDENTIALS_USR} -p ${DOCKER_CREDENTIALS_PSW}"
                    bat "docker push ${IMAGE_NAME}:${env.IMAGE_TAG}"
                }
            }
        }
    }
}
