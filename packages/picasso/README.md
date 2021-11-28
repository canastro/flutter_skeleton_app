# Picasso

A design system for flutter apps that uses the general Shooda design language.

## Usage 

To make picasso context accessible in the app:

```dart
void main() => runApp(
    PicassoProvider(
        data: PicassoData(),
        child: MyApp(),
    ),
);
```

To access the data use:

```dart
PicassoData.of(context);
```

Then, add it the generated theme into `MaterialApp`: 

```dart
MaterialApp(
// ...
  theme: PicassoData.of(context).materialLightTheme,
// ...
);
```

Then, the theme can be accessed via:

```dart
PicassoData.themeOf(context);
```

