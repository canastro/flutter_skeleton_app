# Android Workflow

## Account setup
* Create app on https://play.google.com/console
  * Fill all the details on the onboarding workflow at the dashboard
* Create service account on https://console.cloud.google.com/ for Google Play Android Developer API
  * Add a key and download the JSON file
* On https://play.google.com/console go to `Setup > API Access`, grant access to your new Service Account and provide release permissions to your app.


## Initial manual release
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

Once you've done the intial manual release, you can comment `signingConfigs` as the sigining will be done in a different step in our GH actions.

## Setup GH actions secrets
* GCP_SERVICE_ACCOUNT => the contents of the json file you downloaded for your service account
* KEYSTORE_ALIAS => the alias used in `keytool` command
* KEYSTORE_PASSWORD => the keystore password you defined in the `keytool` command 
  * Note: I used the same password for the keystore and the actual key
* KEYSTORE_SIGNING_KEY => the base64 version of the keystore contents
  * `openssl base64 < ~/upload-keystore.jks | tee upload-keystore.jks.base64.txt`

## Useful links
* https://www.raywenderlich.com/19407406-continuous-delivery-for-android-using-github-actions
* https://www.freecodecamp.org/news/use-github-actions-to-automate-android-development/
