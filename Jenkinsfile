pipeline {
    agent any
    environment {
        CI = "true"
        ECR_REPOSITORY = "772413732375.dkr.ecr.eu-west-2.amazonaws.com/cloud-devops-nanodegree-capstone"
        KUBECONFIG = "/home/ubuntu/.kube/config"
    }
    stages {
        stage('test') {
            agent {
                docker { image 'node:12' }
            }
            environment {
                HOME = '.'
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
            when {
                branch 'master'
            }
            steps {
                withAWS(credentials:'aws-credential') {
                    script {
                        def login = ecrLogin()
                        sh "${login}"
                    }
                    sh 'docker version'
                    sh 'docker build -t "$ECR_REPOSITORY:$GIT_COMMIT" .'
                    sh 'docker push "$ECR_REPOSITORY:$GIT_COMMIT"'
                    sh 'docker tag "$ECR_REPOSITORY:$GIT_COMMIT" "$ECR_REPOSITORY:latest"'
                    sh 'docker push "$ECR_REPOSITORY:latest"'
                }
            }
        }
        stage('deploy') {
            // when {
            //     branch 'master'
            // }
            steps {
                withAWS(credentials:'aws-credential'){
                    sh 'kubectl version'
                    sh 'kubect apply -f kube/deployment.yaml'
                }
            }
        }
    }
}
