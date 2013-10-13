#!/bin/bash
APP=$1
echo "starting with execution"
nvm use 0.10.17
cd /home/nodejs/nodeapps/${APP}
source /home/nodejs/${APP}_env.properties
npm start >> /var/log/${APP}.sys.log 2>&1
echo "execution done"
