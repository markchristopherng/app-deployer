#!/bin/bash
# Script to set the bamboo variables for travelcard app

export android_sdk="/Users/markng/Library/Android/sdk"
export bamboo_appName="app1"
export bamboo_releaseKeyPassword="dummy_password"
export bamboo_releaseKeystorePassword="dummy_password"
export bamboo_unsignedApkName="app1_unsigned.apk"
export bamboo_zipalignedApkName="app1_zipaligned"
export bamboo_signedApkName="app1_release.apk"
export bamboo_serviceAccount="<SET_TO_YOUR_ACCOUNT>.iam.gserviceaccount.com"

./build_script.sh