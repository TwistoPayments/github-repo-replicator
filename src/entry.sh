#!/usr/bin/env bash

set -x

UPSTREAM_REPO=$1
UPSTREAM_DEPLOYKEY=$2
DOWNSTREAM_REPO=$3
DOWNSTREAM_DEPLOYKEY=$4
STREAM_BRANCH=$5

if [[ -z "$STREAM_BRANCH" ]]; then
  echo "STREAM_BRANCH not set."
  exit 1
fi
if [[ -z "$UPSTREAM_REPO" ]]; then
  echo "UPSTREAM_REPO not set."
  exit 1
fi
if [[ -z "$UPSTREAM_DEPLOYKEY" ]]; then
  echo "UPSTREAM_DEPLOYKEY not set."
  exit 1
else
  echo $UPSTREAM_DEPLOYKEY > /home/ghreplicator/.ssh/upstream_deploy_key
  chmod 700 /home/ghreplicator/.ssh/upstream_deploy_key
fi
if [[ -z "$DOWNSTREAM_REPO" ]]; then
  echo "DOWNSTREAM_REPO not set."
  exit 1
fi
if [[ -z "$DOWNSTREAM_DEPLOYKEY" ]]; then
  echo "DOWNSTREAM_DEPLOYKEY not set."
  exit 1
else
  echo $DOWNSTREAM_DEPLOYKEY > /home/ghreplicator/.ssh/downstream_deploy_key
  chmod 700 /home/ghreplicator/.ssh/downstream_deploy_key
fi

git clone "git@upstream-github-repo:${UPSTREAM_REPO}.git" upstream_dir
cd upstream_dir || { echo "Missing upstream dir" && exist 2 ; }
git remote set-url origin "git@downstream-github-repo:${DOWNSTREAM_REPO}.git"

git remote add upstream "$UPSTREAM_REPO"
git fetch upstream
git checkout ${STREAM_BRANCH}
git push origin

cd ..
rm -rf upstream_dir
