pipeline {
    agent any

    environment {
        ARGO_SERVER = "http://172.20.0.2:32407"
    }

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/sonalmallah12/CICD'
            }
        }

        stage('Build in Jenkins') {
            steps {
                sh '''
                echo "Running Build Inside Jenkins"
                chmod +x app.sh
                ./app.sh
                '''
            }
        }

        stage('Trigger Argo Workflow') {
            steps {
                withCredentials([string(credentialsId: 'argo-token', variable: 'ARGO_TOKEN')]) {

                    sh '''
                    argo submit argo-workflow.yaml \
                      --server ${ARGO_SERVER} \
                      --auth-token ${ARGO_TOKEN} \
                      --watch
                    '''
                }
            }
        }

    }
}

