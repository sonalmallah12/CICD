pipeline {
  agent any

  environment {
    IMAGE = "sonalmallah12/ci-cd:${BUILD_NUMBER}"
    SONAR_TOKEN = credentials('sqp_e00ae4ef0c8265a5e8aff0d35c0d04391c0e232d')
    ARGO_TOKEN  = credentials('eyJhbGciOiJSUzI1NiIsImtpZCI6Ikc4dzFyQW52dUltZ1dsRVY3SktzM2ZPUEV0LWEwOUpaZW1Wc3J1NUtTeWsifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjLmNsdXN0ZXIubG9jYWwiLCJrM3MiXSwiZXhwIjoxNzcwMTAzNzgyLCJpYXQiOjE3NzAxMDAxODIsImlzcyI6Imh0dHBzOi8va3ViZXJuZXRlcy5kZWZhdWx0LnN2Yy5jbHVzdGVyLmxvY2FsIiwianRpIjoiYWYwNjEwMzUtMmI3ZC00NGU0LWFiMGYtNTQxNTUyMTc5ZGVjIiwia3ViZXJuZXRlcy5pbyI6eyJuYW1lc3BhY2UiOiJhcmdvIiwic2VydmljZWFjY291bnQiOnsibmFtZSI6ImFyZ28td29ya2Zsb3ciLCJ1aWQiOiJhNjgxMDMyMi04OGNjLTQ0NDAtOTIyMC0wMzUxOTFjNmI2M2UifX0sIm5iZiI6MTc3MDEwMDE4Miwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50OmFyZ286YXJnby13b3JrZmxvdyJ9.F52E3T6lQhv5MdzTNqpr9Ul0ZwBy9C9KOrfM61EjioOWK-2npOu2VOfRq8ZjcBcRuCihP1r36bobhlTjkiw5wURS9ZcUmamoAgU6T20ZH-BpY0qwxif2U3kDiepgiWyt7bKWpnQlHDX6nXrUOyuFvDRfr_5NQ3wMZNVHO8MbIl7bo-8qEt_ZVFAgV22TlnIqXQHrGOI0nxuEP054mO1l2FDD4VTgp4wsCxjKNP2yu-4h9gsEnAV03RpVtiWyqyQtdDjiKdC4zJOKkYGD7_cch8KiaXOPk2xm-U3pzbHTEo3TNFDkDLecLaUb6ojz5hw1Jxm42_uFU5_hGKtWyX1fPg')
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
          sh """
          sonar-scanner \
            -Dsonar.projectKey=ci-cd \
            -Dsonar.sources=.
          """
        }
      }
    }

    stage('Docker Build & Push') {
      steps {
        sh """
        docker build -t $IMAGE .
        docker tag $IMAGE sonalmallah12/ci-cd:latest
        docker push $IMAGE
        docker push sonalmallah12/ci-cd:latest
        """
      }
    }

    stage('Trigger Argo Workflow') {
      steps {
        sh """
        curl -X POST \
          http://argo-workflows-server.argo.svc.cluster.local:2746/api/v1/workflows/argo \
          -H "Authorization: Bearer $ARGO_TOKEN" \
          -H "Content-Type: application/yaml" \
          --data-binary @argo-workflow.yaml
        """
      }
    }
  }
}

