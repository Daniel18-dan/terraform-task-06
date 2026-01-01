pipeline {
    agent any

    /*
     * Parameters shown in Jenkins UI
     */
    parameters {
        string(
            name: 'AMI_ID',
            defaultValue: 'ami-0fc5d935ebf8bc3bc',
            description: 'AMI ID for EC2 (us-east-1)'
        )

        choice(
            name: 'INSTANCE_TYPE',
            choices: ['t2.micro'],
            description: 'EC2 instance type'
        )

        string(
            name: 'OWNER',
            defaultValue: 'Daniel',
            description: 'Owner of the EC2 instance'
        )
    }

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {

        stage('Get Terraform Code') {
            steps {
                echo 'Downloading infrastructure code'
                git(
                    branch: 'main',
                    url: 'https://github.com/Daniel18-dan/terraform-jenkins-task6.git',
                    credentialsId: 'github-token'
                )
            }
        }

        stage('Prepare Terraform') {
            steps {
                echo 'Preparing Terraform'
                sh 'cd env/dev && terraform init'
            }
        }

        stage('Review Infrastructure Changes') {
            steps {
                echo 'Reviewing what Terraform will create'
                sh '''
                    cd env/dev &&
                    terraform plan \
                      -var="ami_id=${AMI_ID}" \
                      -var="instance_type=${INSTANCE_TYPE}" \
                      -var="owner=${OWNER}" \
                      -var="environment=DEV"
                '''
            }
        }

        stage('Approval Required') {
            steps {
                input message: 'Approve infrastructure creation?', ok: 'Approve'
            }
        }

        stage('Create Infrastructure') {
            steps {
                echo 'Creating EC2 instance'
                sh '''
                    cd env/dev &&
                    terraform apply -auto-approve \
                      -var="ami_id=${AMI_ID}" \
                      -var="instance_type=${INSTANCE_TYPE}" \
                      -var="owner=${OWNER}" \
                      -var="environment=DEV"
                '''
            }
        }
    }
}
