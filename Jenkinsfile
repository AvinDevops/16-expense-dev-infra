pipeline {
    agent {
        label 'AGENT-1'
    }
    options {
        timeout(time:30, unit:'MINUTES')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }

    parameters {
        choice(name: 'action', choices: ['Apply', 'Destroy'], description: 'Pick something')
    }

    stages {
        stage('Init') {
            steps {
                sh """
                    cd 01-vpc
                    terraform init -reconfigure
                """
            }
        }
        stage('Plan') {
            when {
                expression {
                    params.action == 'Apply'
                }
            }
            steps {
                sh """
                    cd 01-vpc
                    terraform plan
                """
                
            }
        }
        stage('Apply') {
            input {
                message "Should we continue?"
                ok "Yes, we should."
            }
            when {
                expression {
                    params.action == 'Apply'
                }
            }
            steps {
                sh """
                    cd 01-vpc
                    terraform apply -auto-approve
                """
            }
        }
        stage('Destroy') {
            when {
                expression {
                    params.action == 'Destroy'
                }
            }
            steps {
                sh """
                    cd 01-vpc
                    terraform destroy -auto-approve
                """
            }
        }
    
    }
    post {
        always {
            echo 'I will always run.'
            deleteDir()
        }
        success {
            echo 'I will run only when pipeline is success'
        }
        failure {
            echo 'I will run only when pipeline is failure'
        }
    }
}