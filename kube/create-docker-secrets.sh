ECR_REPOSITORY="772413732375.dkr.ecr.eu-west-2.amazonaws.com"
TOKEN=$(aws ecr get-authorization-token --output text --query 'authorizationData[].authorizationToken')

kubectl create secret docker-registry aws-ecr-cred \
    --docker-server="${ECR_REPOSITORY}" \
    --docker-username=AWS \
    --docker-password="${TOKEN}" \
    --docker-email=no@email.com
