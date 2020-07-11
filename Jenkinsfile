pipeline {
    agent any
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
        // stage('test aws-cli') {
        //     agent {
        //         docker { image 'amazon/aws-cli:2.0.30' }
        //     }
        //     steps {
        //         sh 'aws ecr help'
        //     }
        // }
        stage('test') {
            agent {
                docker { image 'node:12' }
            }
            when {
                not {
                    branch 'master'
                }
            }
            steps {
                sh 'npm ci'
                sh 'npm run lint'
                sh 'npm test'
            }
        }
        stage('build container') {
            // when {
            //     branch 'master'
            // }
            steps {
                echo "I'm building the docker container"
                withAWS(region:'eu-west-2',credentials:'aws-deploy') {
                    sh 'docker version'
                    sh 'docker login --username AWS -p $DOCKER_PASSWORD $ECR_REPOSITORY'
                    sh 'docker build -t "$ECR_REPOSITORY:$GIT_COMMIT" .'
                    sh 'docker push "$ECR_REPOSITORY:$GIT_COMMIT"'
                    sh 'docker tag $"ECR_REPOSITORY:$GIT_COMMIT" "$ECR_REPOSITORY:latest"'
                    sh 'docker push "$ECR_REPOSITORY:latest"'
                }
            }
        }
    }
}
