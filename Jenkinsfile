pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/sonalmallah12/CICD.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t sonalmallah12/ci-cd:${BUILD_NUMBER} .'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push sonalmallah12/ci-cd:${BUILD_NUMBER}'
            }
        }
    }


