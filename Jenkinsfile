pipeline {
    agent any

    environment {
        IMAGE = "sonalmallah12/cicd-app:v1"
    }

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/sonalmallah12/CICD.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE .'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push $IMAGE'
            }
        }

    }
}

