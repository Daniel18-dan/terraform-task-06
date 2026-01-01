pipeline {
  agent any

  environment {
    AWS_DEFAULT_REGION = 'us-east-1'
  }

  stages {

    stage('Terraform Init') {
      steps {
        echo 'Initializing Terraform'
        withCredentials([
          string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
          string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
        ]) {
          sh 'cd env/dev && terraform init'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        echo 'Planning infrastructure'
        withCredentials([
          string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
          string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
        ]) {
          sh 'cd env/dev && terraform plan'
        }
      }
    }

    stage('Manual Approval') {
      steps {
        input message: 'Approve Terraform apply?', ok: 'Apply'
      }
    }

    stage('Terraform Apply') {
      steps {
        echo 'Applying infrastructure'
        withCredentials([
          string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
          string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
        ]) {
          sh 'cd env/dev && terraform apply -auto-approve'
        }
      }
    }
  }
}
