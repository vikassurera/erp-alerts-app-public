# ERP Alerts

App to get internship and placement push notifications from IIT KGP ERP

> [!Warning]
> This tool is open source, but the way you use it can get you into trouble. Some things you **cannot** do are:
> - Use this tool to send CDC notifications to **any non-KGPian**.
> - Use this tool on a wide scale or publicise its running instance without consent from the author
>
> Please use this tool responsibly and within ethical and legal bounds. We do not promote violating company policies or laws. The extent of the punishment may very **from disciplinary action by the institute to blacklisting from CDC process**.

## Setup
1. Connect to firebase - make sure you download the `google-services.json` file in proper location.

2. Make sure to replace all variables `<variable-name>`




## Deployment Notes
### 1. Create keystore file to sign the app
- Validity: in days 
- Alias: `upload`

```shell
keytool -genkey -alias $alias -keystore <upload-keystore.jks> -storepass <keystore-pass> -keypass <key-pass> -keyalg RSA -keysize 2048 -validity 9855
```

Create the `upload_certificate.pem` file and upload it to play store console

```shell
keytool -export -rfc -alias <alias> -file upload_certificate.pem -keystore <upload-keystore.jks> -storepass <keystore-pass>
```

Save file in `android/app` directory

### 2. Update keystore properties 

Update the keystore properties in `android/keystore.properties` file

```shell
prodStorePassword=<keystore-pass>
prodKeyPassword=<key-pass>
prodKeyAlias=<alias>
prodStoreFile=<upload-keystore.jks>
```

### 3. Build the flutter app bundle

Make sure to update the version and build number in `pubspec.yaml` file

```shell
flutter build appbundle --release
```

output file: `build/app/outputs/bundle/release/app-release.aab`

### 4. Upload the app bundle to play store console
### 5. Create a new release in play store console



## Publish to PlayStore Pipeline
This document describes the GitHub Actions workflow for publishing an Android application to the Google Play Store.

### Workflow Overview
The workflow is triggered on a push to the `master` branch. It consists of two jobs: `build` and `publish`.

#### Build Job
The `build` job performs the following steps:

1. Checks out the repository.
2. Downloads the Android keystore file from a base64-encoded secret and places it in the workspace.
3. Creates a `keystore.properties` file with the necessary information for signing the application.
4. Sets up Flutter with the specified version.
5. Retrieves the project dependencies with `flutter pub get`.
6. Creates a `config.dart` file using a script and secret environment variables.
7. Builds the application bundle with `flutter build appbundle --release`.
8. Uploads the built application bundle as an artifact.
9. Sends a Slack notification if the build fails.

#### Publish Job
The `publish` job performs the following steps:

1. Decodes a base64-encoded service account JSON file and saves it to the workspace.
2. Downloads the built application bundle artifact.
3. Deploys the application bundle to the Google Play Store's internal track using the `1r0adkll/upload-google-play` action.
4. Sends a Slack notification if the deployment fails or succeeds.

### Secrets
The workflow requires the following secrets:

- `KEYSTORE_BASE64`: The base64-encoded Android keystore file.
- `KEYSTORE_ALIAS`: The alias of the keystore.
- `KEYSTORE_PASSWORD`: The password for the keystore.
- `KEYSTORE_KEY_PASSWORD`: The password for the key.
- `RAZORPAY_API_KEY`, `MIXPANEL_KEY`, `GOOGLE_CLIENT_ID`: Keys for creating the `config.dart` file.
- `SERVICE_ACCOUNT_JSON`: The base64-encoded service account JSON file for Google Play Store deployment.
- `SLACK_NOTIFICATIONS_BOT_TOKEN`: The token for the Slack bot that sends notifications.

### Notifications
The workflow sends notifications to the `deploy` Slack channel. Notifications are sent when the build fails, when the deployment to the Play Store fails, and when the deployment to the Play Store succeeds.
