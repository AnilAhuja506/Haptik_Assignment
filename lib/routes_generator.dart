import 'package:flutter/material.dart';
import 'package:haptik_assignment/screens/home_screen.dart';
import 'package:haptik_assignment/screens/post_deatil.dart';
import 'package:haptik_assignment/screens/splash_screen.dart';

class GenerateRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    ScrollController scrollController = new ScrollController();

    switch (settings.name) {
      case SplashScreen.id:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case HomeScreen.id:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
        case PostDetailScreen.id:
        return MaterialPageRoute(
          builder: (_) => PostDetailScreen(postId: args,),
        );
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
