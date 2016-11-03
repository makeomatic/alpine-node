#!/bin/bash

set -e

#set the DEBUG env variable to turn on debugging
[[ -n "$DEBUG" ]] && set -x

# global env vars
export \
  PROJECT=node \
  NAMESPACE=makeomatic \
  PUSH_NAMESPACES=makeomatic \
  BASE_NAME=makeomatic/node

# install basic scripts
curl -sSL https://github.com/makeomatic/ci-scripts/raw/master/install.sh | sh -s
git clone https://github.com/docker-library/official-images.git ~/official-images

# add scripts to PATH
export PATH=$PATH:~/ci-scripts
[ ${BRANCH_NAME} == master ] || export variant=${BRANCH_NAME}

# build base node images that are used further in the project
docker-build -v "${variant}" $BASE_NAME -f node/Dockerfile .
docker-build -v "${variant}-onbuild" $BASE_NAME -f node/Dockerfile.onbuild .
docker-build -v "${variant}-tester" $BASE_NAME -f node/Dockerfile.tester .
docker-build -v "${variant}-tester-glibc" $BASE_NAME -f node/Dockerfile.tester-glibc .
# build node images with ruby
docker-build -v "${variant}-ruby" $BASE_NAME -f node-ruby/Dockerfile .
# build node images with ssh embedded
docker-build -v "${variant}-ssh" $BASE_NAME -f node-ssh/Dockerfile .
docker-build -v "${variant}-ssh-onbuild" $BASE_NAME -f node-ssh/Dockerfile.onbuild .
# build node images with libvips
docker-build -v "${variant}-vips" $BASE_NAME -f node-vips/Dockerfile .
docker-build -v "${variant}-vips-onbuild" $BASE_NAME -f node-vips/Dockerfile.onbuild .
docker-build -v "${variant}-vips-tester-glibc" $BASE_NAME -f node-vips/Dockerfile.tester-glibc .
# build node images with libvips & ssh
docker-build -v "${variant}-vips-ssh" $BASE_NAME -f node-vips-ssh/Dockerfile .
docker-build -v "${variant}-vips-ssh-onbuild" $BASE_NAME -f node-vips-ssh/Dockerfile.onbuild .

# List of newly created images
export images=$(docker images | grep "^$BASE_NAME" | tr -s '[:space:]' | cut -f1,2 -d' ' | sed 's/ /:/')

# we actually need to
# Push to docker when DEPLOY is true
# docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
[ ${BRANCH_NAME} == master ] && for image in $images; do docker push $image; done

# report
docker images
