#!/bin/bash

###
# build selected dockerfile and tag it based in labels
##

set -o errexit

while getopts "t:v:c:f:p" opt; do
    case $opt in
        t)
          # custom temporary image name
          _tempname=$OPTARG
          ;;
        p)
          # also push to remote repo
          push=true
          ;;
        c)
          # specifies image tag with layers to speed up the build
          cache=$OPTARG
          ;;
        v)
          # specifies variant which is appended to versions (aka: image:16.04-variant)
          # if is not set - also "latest" tag will be generated
          variant=$OPTARG
          ;;
        f)
          file=$OPTARG
          ;;
    esac
done

if [ -z "$file" ]; then
  echo "USAGE: cmd -f ./Dockerfile [-p postfix] [-c cache-tag]"
  exit 1
fi

image="makeomatic/node"
tempname=${_tempname:-`cat /dev/urandom | LC_CTYPE=C tr -dc 'a-z0-9' | fold -w 32 | head -n 1`}
versions_label="version_tags"
cachename="$image:$cache"

### create temp container
[ ! -z "$cache" ] && docker pull $cachename

buildArgs=("--tag $tempname" "--file $file")
[ ! -z "$cache" ] && buildArgs+=("--cache-from $cachename")
buildArgsStr=$(printf " %s" "${buildArgs[@]}")

docker build $buildArgsStr .

### generate tags based on image labels
[ `uname` = "Darwin" ] && opts="-E" || opts="-r"
versions=$(docker inspect -f "{{.Config.Labels.$versions_label}}" $tempname | sed $opts -e 's/"|\[|\]//g' -e 's/,/ /g')

[ -z $variant ] && versions+=("latest")

### tag images
for version in $versions; do
  tag=${version}-${variant}
  tag=${tag%-}

  docker tag $tempname $image:$tag
  echo "==> tagged: $image:$tag"
done

### remove unwanted images if we not specify exact temp name (test purposes)
[ -z $_tempname ] &&  docker rmi $tempname

### push images to remote repository
if [ ! -z "$push" ]; then
  for version in $versions; do
    tag=${version}-${variant}
    tag=${tag%-}
    docker push $image:$tag
  done
fi
