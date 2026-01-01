pipeline {
  agent any

  parameters {
    string(
      name: 'AMI_ID',
      defaultValue: 'ami-0fc5d935ebf8bc3bc',
      description: 'AMI ID for us-east-1'
    )

    choice(
      name: 'INSTANCE_TYPE',
      choices: ['t2.micro'],
      description: 'EC2 instance type'
    )

    string(
      name: 'OWNER',
      defaultValue: 'Daniel',
      description: 'Resource owner'
    )
  }

  environment {
    AWS_DEFAULT_REGION = 'us-east-1'
  }

  stages {

    stage('Terraform Init') {
      steps {
        echo 'Initializing Terraform'
        sh 'cd env/dev && terraform init'
      }
    }

    stage('Terraform Plan') {
      steps {
        echo 'Planning infrastructure'
        sh """
          cd env/dev &&
          terraform plan \
            -var="ami_id=${AMI_ID}" \
            -var="instance_type=${INSTANCE_TYPE}" \
            -var="owner=${OWNER}" \
            -var="environment=DEV"
        """
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
        sh """
          cd env/dev &&
          terraform apply -auto-approve \
            -var="ami_id=${AMI_ID}" \
            -var="instance_type=${INSTANCE_TYPE}" \
            -var="owner=${OWNER}" \
            -var="environment=DEV"
        """
      }
    }
  }
}
