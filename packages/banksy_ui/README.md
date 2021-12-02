# BanksyUi

A design system for flutter apps that uses the general FlutterSkeletonApp design language.

## Usage 

To make banksy_ui context accessible in the app:

```dart
void main() => runApp(
    BanksyUiProvider(
        data: BanksyUiData(),
        child: MyApp(),
    ),
);
```

To access the data use:

```dart
BanksyUiData.of(context);
```

Then, add it the generated theme into `MaterialApp`: 

```dart
MaterialApp(
// ...
  theme: BanksyUiData.of(context).materialLightTheme,
// ...
);
```

Then, the theme can be accessed via:

```dart
BanksyUiData.themeOf(context);
```

