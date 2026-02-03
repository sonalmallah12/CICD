pipeline {
  agent any
 
  environment {
    IMAGE = "sonalmallah12/ci-cd:${BUILD_NUMBER}"
    ARGO_TOKEN = credentials('argo-token')
    SONARQUBE_TOKEN = credentials('sonarqube-token')
  }
 
  stages {
 
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
 
    stage('SonarQube Scan') {
      steps {
        withSonarQubeEnv('SonarQube') {
          sh '''
            sonar-scanner \
              -Dsonar.projectKey=ci-cd \
              -Dsonar.sources=.
          '''
        }
      }
    }
 
    stage('Docker Build & Push') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'dockerhub-creds',
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS'
        )]) {
          sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker build -t $IMAGE .
            docker tag $IMAGE sonalmallah12/ci-cd:latest
            docker push $IMAGE
            docker push sonalmallah12/ci-cd:latest
          '''
        }
      }
    }
 
    stage('Trigger Argo Workflow') {
      steps {
        sh '''
          curl -X POST \
http://argo-workflows-server.argo.svc.cluster.local:2746/api/v1/workflows/argo?submit=true \
            -H "Authorization: Bearer $ARGO_TOKEN" \
            -H "Content-Type: application/json" \
            --data-binary @argo-workflow.yaml
        '''
      }
    }
  }
}
