# WIP
This is not something I'll support for public usage... Feel free to fork it, copy it, etc.

# Flutter skeleton app
A skeleton to use when creating a new app with flutter.

## This repo includes
* Translations
* Github actions workflows (not fully tested yet)
* UI package with theme configuration
* QA / PROD entrypoints
* Clean architecture
* Build scripts and makefile
* Firebase Analytics
* Firebase Crashlytics (WIP)


## Crashlytics
In order to upload the dSYMs to crashlytics you'll have to:

1.Create archive:

```bash
xcodebuild \
  -workspace ./app/ios/Runner.xcworkspace \
  -config Release \
  -scheme Runner \
  -archivePath ./app/ios/build/flutterskeletonapp.xcarchive \
  -destination 'generic/platform=iOS' \
  archive
```

2. Upload dsyms:

```bash
app/ios/Pods/FirebaseCrashlytics/upload-symbols \
  -gsp app/ios/Runner/GoogleService-Info.plist \
  -p ios \
  app/ios/build/flutterskeletonapp.xcarchive/dSYMs
```

This process will eventually be added to the release.yml workflow.
