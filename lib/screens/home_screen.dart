import 'package:flutter/material.dart';
import 'package:haptik_assignment/core/responsive/builders/orientation_layout.dart';
import 'package:haptik_assignment/core/responsive/builders/screen_type_layout.dart';
import 'package:provider/provider.dart';

import 'home_screen_moble_portrait.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'homescreen';
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: StreamProvider<NetworkStatus>(
          create: (context) =>
              NetworkStatusService().networkStatusController.stream,child: HomeScreenMobilePortrait()),
      ),
    );
  }
}
