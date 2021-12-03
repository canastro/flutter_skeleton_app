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


### First manual release
Start by doing a manual release before using the workflow to ship new versions

1. Generate keystore:

```bash
keytool -genkey -v -keystore ~/Documents/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

2. Change buildTypes `app/android/app/build.gradle`;
```
buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
```

3. Create a `app/android/key.properties`:

```
storePassword=PASSWORD
keyPassword=PASSWORD
keyAlias=upload
storeFile=/Users/username/Documents/upload-keystore.jks
```

4. Run `flutter build appbundle --verbose --release -t lib/main_prod.dart --build-name=0.0.1`

5. Upload generated .aab to Playstore.

### Setup GH actions

1. Convert your keystore to base64: 
```bash
openssl base64 < ~/upload-keystore.jks | tee upload-keystore.jks.base64.txt
```



## Useful links
* Create gh actions to relase ios: https://github.com/Apple-Actions
* https://developer.apple.com/documentation/appstoreconnectapi/creating_api_keys_for_app_store_connect_api
* https://www.raywenderlich.com/19407406-continuous-delivery-for-android-using-github-actions
* https://www.freecodecamp.org/news/use-github-actions-to-automate-android-development/
