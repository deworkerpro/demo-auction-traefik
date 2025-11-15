pipeline {
    agent any
    options {
        timestamps()
    }
    stages {
        stage ('Prod') {
            when {
                branch 'master'
            }
            steps {
                withCredentials([
                    string(credentialsId: 'PRODUCTION_HOST', variable: 'HOST'),
                    string(credentialsId: 'PRODUCTION_PORT', variable: 'PORT'),
                ]) {
                    sshagent (credentials: ['PRODUCTION_AUTH']) {
                        sh 'mkdir -p ~/.ssh'
                        sh 'ssh-keyscan -p ${PORT} -H ${HOST} > ~/.ssh/known_hosts'
                        sh 'make deploy'
                    }
                }
            }
        }
    }
    post {
        failure {
            emailext (
                subject: "FAIL Job ${env.JOB_NAME} ${env.BUILD_NUMBER}",
                body: "Check console output at: ${env.BUILD_URL}/console",
                recipientProviders: [[$class: 'DevelopersRecipientProvider']]
            )
        }
    }
}
