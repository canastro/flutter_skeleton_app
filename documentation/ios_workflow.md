# iOS Workflow

## Account setup
* Create app at https://appstoreconnect.apple.com/
* Go to https://developer.apple.com/account/resources/certificates/list
  * Create `iOS distribution` and `iOS development` certificates
  * Download and add them to your keychain
  * In your keychain export the `iOS distribution` certificate as a .p12
* In XCode go to Preferences > Accounts and add those certificates
* Go to https://developer.apple.com/account/resources/profiles/list
  * Generate a `App Store` provision profile
  * Download and double click to add it to XCode
* In XCode change the release siging to manually with the recently installed provision profile
* Create access key for appstoreconnect upload at https://appstoreconnect.apple.com/access/api
* Update `app/ios/export-options.plist` with the appropriate data for your team / provision

## Setup GH actions secrets
* APPSTORE_ISSUER_ID => The AppStoreConnect API Key Issuer Identifier
* APPSTORE_KEY_ID => The Key ID for AppStore Connect API
* APPSTORE_PRIVATE_KEY => The PKCS8 format Private Key for AppStore Connect API
* SIGNING_CERTIFICATE_P12_DATA => The base64 of your `iOS distribution` p12
  * run `base64 <certificate_name>.p12 | pbcopy`
* SIGNING_CERTIFICATE_PASSWORD => The password set for your p12 certificate


## Useful links
* Create gh actions to relase ios: https://github.com/Apple-Actions
* https://developer.apple.com/documentation/appstoreconnectapi/creating_api_keys_for_app_store_connect_api
