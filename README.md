# WIP
This is not something I'll support for public usage... Feel free to fork it, copy it, etc.

# Flutter skeleton app
A skeleton to use when creating a new app with flutter.

## This repo includes
* Clean architecture
* UI package with theme configuration
* QA / PROD entrypoints
* Dummy authentication workflow
* Translations
* Firebase 
  * Analytics
  * Crashlytics (WIP)
* CI / CD
  * Github actions workflows (not fully tested yet)
    * Publish to testflight
    * Publish to google playstore (WIP)
  * Build scripts and makefile
  * Encrypted firebase configuration files


## Crashlytics
In order to upload the dSYMs to crashlytics you'll have to:

Upload dsyms:

```bash
app/ios/Pods/FirebaseCrashlytics/upload-symbols \
  -gsp app/ios/Runner/GoogleService-Info.plist \
  -p ios \
  app/ios/build/flutterskeletonapp.xcarchive/dSYMs
```

This process will eventually be added to the release.yml workflow.

## Release for android
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias FLUTTER_SKELETON_APP_KEYSTORE -storetype JKS

openssl base64 < ~/upload-keystore.jks | tr -d '\n' | tee upload-keystore.jks.base64.txt
```

## Useful links
* Create gh actions to relase ios: https://github.com/Apple-Actions
* https://developer.apple.com/documentation/appstoreconnectapi/creating_api_keys_for_app_store_connect_api
* https://www.raywenderlich.com/19407406-continuous-delivery-for-android-using-github-actions
