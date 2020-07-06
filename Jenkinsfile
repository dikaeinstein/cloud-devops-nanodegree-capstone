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
        stage('build container') {
            agent any
            when {
                branch 'master'
            }
            steps {
                withAWS(region:'eu-west-2',credentials:'aws-deploy') {
                    sh 'aws ecr get-login-password --region | docker login --username AWS --password-stdin $ECR_REPOSITORY'
                    sh 'docker build -t "$ECR_REPOSITORY:$GIT_COMMIT" .'
                    sh 'docker push "$ECR_REPOSITORY:$GIT_COMMIT"'
                    sh 'docker tag $"ECR_REPOSITORY:$GIT_COMMIT" "$ECR_REPOSITORY:latest"'
                    sh 'docker push "$ECR_REPOSITORY:latest"'
                }
            }
        }
    }
    post {
        always {
            echo 'I will always say Hello again!'
            sh 'sudo chown jenkins: -R \$PWD/'
        }
    }
}
