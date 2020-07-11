pipeline {
    agent {
        docker { image 'node:12' }
    }
    environment {
        // AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        // AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
        // AWS_DEFAULT_REGION    = "eu-west-2"
        CI = 'true'
        DOCKER_PASSWORD = credentials('jenkins-ecr-login-password')
        ECR_REPOSITORY = "772413732375.dkr.ecr.eu-west-2.amazonaws.com/cloud-devops-nanodegree-capstone"
        HOME = '.'
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
            agent { label 'node-1' }
            // when {
            //     branch 'master'
            // }
            steps {
                echo "I'm building the docker container"
                sh 'docker version'
                // sh 'docker login --username AWS -p $DOCKER_PASSWORD $ECR_REPOSITORY'
                // sh 'docker build -t "$ECR_REPOSITORY:$GIT_COMMIT" .'
                // sh 'docker push "$ECR_REPOSITORY:$GIT_COMMIT"'
                // sh 'docker tag $"ECR_REPOSITORY:$GIT_COMMIT" "$ECR_REPOSITORY:latest"'
                // sh 'docker push "$ECR_REPOSITORY:latest"'
            }
        }
    }
}
