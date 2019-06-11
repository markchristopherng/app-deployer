#!/bin/bash
# Script which handles starting the UI build container, then building the UI inside of it.
# This expects to be run from a bamboo task, hence the $bamboo_X variables. Set these locally if you want to run it locally.
# Call it with no args to start the container
# Call it with 'build' to run the build, test, and upload process

set -euo pipefail

echo "Starting build now"
    
echo "----- Zip align -----"
${android_sdk}/build-tools/28.0.2/zipalign -v 4 ${bamboo_appName}/${bamboo_appName}_unsigned.apk ${bamboo_appName}/${bamboo_appName}_zipaligned.apk
	
echo "----- Sign apk -----"
${android_sdk}/build-tools/28.0.2/apksigner sign --verbose --ks ${bamboo_appName}/${bamboo_appName}-upload.keystore --ks-pass pass:${bamboo_releaseKeystorePassword} --key-pass pass:${bamboo_releaseKeyPassword}  --out ${bamboo_appName}/${bamboo_appName}_release.apk ${bamboo_appName}/${bamboo_appName}_zipaligned.apk

echo "----- Publish to Playstore beta -----"
mkdir app-deployer/app/apk
cp ${bamboo_appName}/${bamboo_appName}_release.apk app-deployer/app/apk/app-release.apk
cd app-deployer
./gradlew publishReleaseApk -PserviceAccount=${bamboo_serviceAccount}
