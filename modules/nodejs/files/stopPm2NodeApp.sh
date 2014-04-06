#!/bin/bash

APP=$1
source ${HOME}/.nvm/nvm.sh
nvm use 0.10

pm2 stop ${APP}
pm2 delete ${APP}
