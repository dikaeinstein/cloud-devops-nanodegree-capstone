pipeline {
    agent { docker
        {
            image 'node:12'
            args '-u root:root'
        }
    }
    environment {
        CI = 'true'
        ECR_REPOSITORY = "772413732375.dkr.ecr.eu-west-2.amazonaws.com/cloud-devops-nanodegree-capstone"
        KUBE_CONFIG = ""
    }
    stages {
        stage('install') {
            when {
                not {
                    branch 'master'
                }
            }
            steps {
                sh 'npm ci'
            }
        }
        stage('test') {
            when {
                not {
                    branch 'master'
                }
            }
            steps {
                sh 'npm run lint'
                sh 'npm test'
            }
        }
        stage('build') {
            when {
                not {
                    branch 'master'
                }
            }
            steps {
                sh 'npm run build'
            }
        }
    }
}
