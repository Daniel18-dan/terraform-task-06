pipeline {
  agent any

  /*
   * Parameters visible in Jenkins UI
   */
  parameters {
    string(
      name: 'AMI_ID',
      defaultValue: 'ami-0fc5d935ebf8bc3bc',
      description: 'AMI ID for us-east-1'
    )

    choice(
      name: 'INSTANCE_TYPE',
      choices: ['t3.micro'],
      description: 'EC2 instance type'
    )

    string(
      name: 'OWNER',
      defaultValue: 'Daniel',
      description: 'Owner tag for EC2 instance'
    )

    string(
      name: 'ENVIRONMENT',
      defaultValue: 'DEV',
      description: 'Environment name'
    )
  }

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
          sh """
            cd env/dev &&
            terraform plan \
              -var="ami_id=${AMI_ID}" \
              -var="instance_type=${INSTANCE_TYPE}" \
              -var="owner=${OWNER}" \
              -var="environment=${ENVIRONMENT}"
          """
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
          sh """
            cd env/dev &&
            terraform apply -auto-approve \
              -var="ami_id=${AMI_ID}" \
              -var="instance_type=${INSTANCE_TYPE}" \
              -var="owner=${OWNER}" \
              -var="environment=${ENVIRONMENT}"
          """
        }
      }
    }
  }
}
