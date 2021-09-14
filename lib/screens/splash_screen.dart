import 'package:flutter/material.dart';
import 'package:haptik_assignment/core/responsive/responsive.dart';
import 'package:haptik_assignment/screens/splash.dart';

class SplashScreen extends StatelessWidget {
  static const String id = 'splashScreen';

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: Splash(),
      ),
    );
  }
}
