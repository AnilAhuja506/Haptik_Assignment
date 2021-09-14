import 'dart:async';
import 'package:flutter/material.dart';
import 'package:haptik_assignment/utilities/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = Duration(seconds: 3);
    prefs = await SharedPreferences.getInstance();
    // previousUser = prefs.getString('user');
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    // Navigator.pushReplacementNamed(context, AuthChecker.id);
    Navigator.pushReplacementNamed(context, HomeScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // body: Align(
      //   alignment: Alignment.bottomCenter,
      //   child: CTAEditor(),
      // ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Center(
                child: Container(
                  height: 150,
                  width: 200,
                  child: Center(
                    child: Hero(
                      tag: 'splashLogo',
                      child: Image.network(
                        'https://image.pngaaa.com/288/619288-middle.png',
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "Haptik Flutter Assignment",
                // style: kBrandTtle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
