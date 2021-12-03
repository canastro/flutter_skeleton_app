# Flutter skeleton app
A skeleton to use when creating a new app with flutter.

PS: This is not something I'll support for public usage... Feel free to fork it, copy it, etc.

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
  * Create changelog via github releases
  * Github actions workflows
    * Publish to testflight
    * Publish to google playstore
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
