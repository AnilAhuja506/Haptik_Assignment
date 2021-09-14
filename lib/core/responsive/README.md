### Create Responsive UI

## How to use?

Step 1: Add this (responsive) folder in your project.

```
- Project name
  - lib
    - responsive
```

Step 2: Create a file name **ui_helper.dart** inside **lib** folder. And add the following code in it.

```dart
//! SizeConfig shortcuts

//get dimensions from [ SizeConfig ]
double get sWidthMultiplier => SizeConfig.widthMultiplier;
double get sHeightMultiplier => SizeConfig.heightMultiplier;

double sWidth(double width) => SizeConfig.setWidth(width);
double sHeight(double height) => SizeConfig.setHeight(height);
double sSp(double size) => SizeConfig.setSp(size);
```

Step 3: To create a screen, you'll need atleast 2 seperate dart files. First one will contain screens for different layouts & second one will contain the actual code.

home_screen.dart
```dart
class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      // mobile UI
      mobile: OrientationLayout(
        // when device orientation is portrait
        portrait: HomeMobilePortrait(),
        // when device orientation is landscape
        landscape: HomeMobileLandscape(),
      ),
      // tablet UI
      tablet: OrientationLayout(
        // when device orientation is portrait
        portrait: HomeaTabletPortrait(),
        // when device orientation is landscape
        landscape: HomeTabletLandscape(),
      ),
    );
  }
}
```

home_mobile_portrait.dart
```dart
class HomeMobilePortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height will vary according to device height
        height: sHeight(100.0),
        // width will vary according to device width
        width: sWidth(100.0),
      ),
    );
  }
}
```

### NOTE

By default design screen dimensions are set as per iPhone 8 (375 x 667).
You can change those in responsive -> utils -> size_config.dart
