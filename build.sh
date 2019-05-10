#!/bin/bash

###
# build selected dockerfile and tag it based in labels
##

set -o errexit

while getopts "t:v:c:f:a:p" opt; do
    case $opt in
        v)
          VERSION=$OPTARG
          ;;
        t)
          _tempname=$OPTARG
          ;;
        p)
          push=true
          ;;
        c)
          cache=$OPTARG
          ;;
        a)
          appendix=$OPTARG
          ;;
        f)
          file=$OPTARG
          ;;
    esac
done

if [ -z "$file" ] || [ -z "$VERSION" ]; then
  echo "
USAGE: cmd -f ./Dockerfile -v 1.12.0 [-p postfix] [-c cache-tag]

  current script generates set of images based on source LABEL version_tags

  arguments:
  -f: path to Dockerfile (requred)
  -v: nodejs version (required)
  -a: version postfix, if not set - additional 'latest' tag will be generated
  -p: push build image to remote repo
  -t: custom temporary image name, it won't be deleted, useful for tests
  -c: image with layer to reuse, useful for speeding up the builds
"
  exit 1
fi

if [[ $VERSION =~ ^([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
  major="${BASH_REMATCH[1]}"
  minor="${BASH_REMATCH[1]}.${BASH_REMATCH[2]}"
  patch="${BASH_REMATCH[1]}.${BASH_REMATCH[2]}.${BASH_REMATCH[3]}"
  VERSION_TAGS="[\\\"$major\\\",\\\"$minor\\\",\\\"$patch\\\"]"
else
  echo "Version $VERSION is not semver-compatible"
  exit 1
fi

image="makeomatic/node"
tempname=${_tempname:-`cat /dev/urandom | LC_CTYPE=C tr -dc 'a-z0-9' | fold -w 32 | head -n 1`}
versions_label="version_tags"
cachename="$image:$cache"

### generate docker image with ENV vars fulfilled
tmpfile=$(mktemp /tmp/dockerfile.XXXXXX)

export VERSION
export VERSION_TAGS

# we specify here exact variables to replace so envsubst won't touch the rest
envsubst '${VERSION} ${VERSION_TAGS}' < $file > $tmpfile

### create temp container
[ ! -z "$cache" ] && docker pull $cachename

buildArgs=("--tag $tempname" "--file $tmpfile")
[ ! -z "$cache" ] && buildArgs+=("--cache-from $cachename")
buildArgsStr=$(printf " %s" "${buildArgs[@]}")

docker build $buildArgsStr .
rm $tmpfile

### generate tags based on image labels
[ `uname` = "Darwin" ] && opts="-E" || opts="-r"
versions=$(docker inspect -f "{{.Config.Labels.$versions_label}}" $tempname | sed $opts -e 's/"|\[|\]//g' -e 's/,/ /g')

[ -z $appendix ] && versions+=("latest")

### tag images
for version in $versions; do
  tag=${version}-${appendix}
  tag=${tag%-}

  docker tag $tempname $image:$tag
  echo "==> tagged: $image:$tag"
done

### remove unwanted images if we not specify exact temp name (test purposes)
[ -z $_tempname ] &&  docker rmi $tempname

### push images to remote repository
if [ ! -z "$push" ]; then
  for version in $versions; do
    tag=${version}-${appendix}
    tag=${tag%-}
    docker push $image:$tag
  done
fi