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

BRANCH_NAME=${BRANCH_NAME:-$(git branch | grep  ^*|cut -d" " -f2)}
echo "working in $BRANCH_NAME"
BRANCH_NAME=$(echo $BRANCH_NAME | sed -e "s/\//-/g")
echo "tagging as $BRANCH_NAME"

# install basic scripts
curl -sSL https://github.com/makeomatic/ci-scripts/raw/master/install.sh | sh -s
[ -d ~/official-images ] || git clone https://github.com/docker-library/official-images.git ~/official-images

# add scripts to PATH
export PATH=$PATH:~/ci-scripts

# cleanup logs
rm -rf ./*.log

# build base node images that are used further in the project
docker-build $BASE_NAME -f node/Dockerfile .
docker-build -v "onbuild" $BASE_NAME -f node/Dockerfile.onbuild .
docker-build -v "tester" $BASE_NAME -f node/Dockerfile.tester .
docker-build -v "tester-glibc" $BASE_NAME -f node/Dockerfile.tester-glibc .
# build node images with ruby
docker-build -v "ruby" $BASE_NAME -f node-ruby/Dockerfile .
# build node images with ssh embedded
docker-build -v "ssh" $BASE_NAME -f node-ssh/Dockerfile .
docker-build -v "ssh-onbuild" $BASE_NAME -f node-ssh/Dockerfile.onbuild .
# build node images with libvips
docker-build -v "vips" $BASE_NAME -f node-vips/Dockerfile .
docker-build -v "vips-onbuild" $BASE_NAME -f node-vips/Dockerfile.onbuild .
docker-build -v "vips-tester" $BASE_NAME -f node-vips/Dockerfile.tester .
docker-build -v "vips-tester-glibc" $BASE_NAME -f node-vips/Dockerfile.tester-glibc .
docker-build -v "vips-tester-chrome" $BASE_NAME -f node-vips/Dockerfile.tester-chrome .
# build node images with libvips & ssh
docker-build -v "vips-ssh" $BASE_NAME -f node-vips-ssh/Dockerfile .
docker-build -v "vips-ssh-onbuild" $BASE_NAME -f node-vips-ssh/Dockerfile.onbuild .

# List of newly created images
images=$(docker images "$BASE_NAME" --format "{{ .Repository }}:{{ .Tag }}")

# we actually need to
# Push to docker when DEPLOY is true
[ ${BRANCH_NAME} = master ] && for image in $images; do docker push $image; done

# report
docker images $BASE_NAME
