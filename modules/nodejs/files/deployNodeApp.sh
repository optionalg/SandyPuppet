#!/bin/bash

APP=$1
APP_ROOT_DIR=${HOME}/nodeapps/${APP}/

source ${HOME}/.nvm/nvm.sh

echo "Stopping ${APP} app"
sudo stop ${APP}

echo "Cleaning code directory"
rm -rf ${APP_ROOT_DIR}/*
tar -vxzf ${APP}.tar.gz -C ${APP_ROOT_DIR}
cd ${APP_ROOT_DIR}
nvm use 0.10.17
npm install
node_modules/bower/bin/bower install
sudo start ${APP}
echo "Started ${APP} app"
