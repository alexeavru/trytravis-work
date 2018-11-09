#!/bin/bash
DOCKER_IMAGE=express42/otus-homeworks
TESTS_RUN=./tests/run.sh


# Prepare network & run container
docker network create hw-test-net
docker run -d -v $(pwd):/srv -v /var/run/docker.sock:/tmp/docker.sock \
-e DOCKER_HOST=unix:///tmp/docker.sock --cap-add=NET_ADMIN -p 33433:22 --privileged \
--device /dev/net/tun --name hw-test --network hw-test-net $DOCKER_IMAGE

# Show versions & run tests
# docker exec hw-test bash -c 'echo -=Get versions=-; ansible --version; ansible-lint --version; packer version; terraform version; tflint --version; docker version; docker-compose --version'

echo '*** START TESTS ***'
docker exec -e USER=appuser hw-test bash -c 'terraform init -var-file=terraform/stage/terraform.tfvars.example terraform/stage; exit $?'
docker exec -e USER=appuser hw-test $TESTS_RUN

docker exec -e USER=appuser hw-test bash -c 'terraform validate -var-file=terraform/stage/terraform.tfvars.example terraform/stage'

#docker exec hw-test bash -c 'ansible-lint -v ansible/*.yml'

#echo 'START PACKER VALIDATE'
#docker exec hw-test bash -c 'find packer -name "*.json" -exec packer validate -var-file=packer/variables.json.example {} \;'

#docker exec hw-test bash -c 'packer validate -var-file=packer/variables.json.example packer/ubuntu16.json; exit $?'

# docker exec -e USER=appuser -e BRANCH=$BRANCH hw-test $HOMEWORK_RUN

