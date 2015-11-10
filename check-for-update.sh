#!/usr/bin/env bash
# Travis CI build script which checks for updates to DynamoDB Local by checking
# the files MD5 checksum. If an update is found, the reference within the
# Dockerfile is updated and pushed to the Git repository; ideal for use with an
# Automated Build on Docker Hub.

set -e

url="dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest"
repo="https://${GH_TOKEN}@github.com/forty8bit/dynamodb-local-docker-image.git"

dockerfile_checksum=$(cat ./Dockerfile | grep -m 1 -oP "CHECKSUM \K\S+")
latest_checksum=$(curl -ILsS "$url" | grep -m 1 -oP "ETag: \"\K\S+(?=\")")

# Note we don't fail the build when the releases match; nothing has gone wrong,
# there's just no need to update the repo.
if [ "$latest_checksum" == "$dockerfile_checksum" ]; then
    echo DynamoDB Local with checksum $dockerfile_checksum still current.
    exit 0
fi

sed -i -e "s/$dockerfile_checksum/$latest_checksum/g" ./Dockerfile

# Email addresses are of course easily accessible; this is just for the sake of
# trying to prevent spam.
git config user.email "$GH_EMAIL"
git config user.name "Gareth Murphy"

git add .
git commit -m "Update to DynamoDB Local checksum $latest_checksum"
commit=$(git rev-parse HEAD)
git checkout master
git merge $commit

# Using --quiet and the output redirect to ensure no sensitive credentials are
# output to the publicly visible log.
git push --quiet $repo master > /dev/null 2>&1
