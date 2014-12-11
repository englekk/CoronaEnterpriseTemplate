#!/bin/bash

# TODO :: apk 파일명 교체

./build.sh "/Applications/eclipse/android-sdk"
/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home/bin/jarsigner -verbose -keystore "/Users/englekk/Dropbox/Private/Certification/Android_DEV/Apollocation_Android.keystore" "./bin/EnterpriseExample-release-unsigned.apk" androes