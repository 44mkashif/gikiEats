import 'package:flutter/material.dart';
import 'package:giki_eats/screens/home.dart';
import 'package:giki_eats/screens/login.dart';
import 'package:giki_eats/screens/signup.dart';
import 'package:giki_eats/screens/welcome.dart';
import 'package:giki_eats/screens/wrapper.dart';

import 'models/user.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Wrapper());

      case '/welcome':
        return MaterialPageRoute(builder: (_) => WelcomePage());

      case '/home':
        if (args is User) {
          return MaterialPageRoute(
            builder: (context) => Home(
              user: args,
            ),
          );
        }
        return _errorRoute();

      case '/login':
        return MaterialPageRoute(builder: (_) => Login());

      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUp());

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('GIKI Eats'),
        ),
        body: Center(
          child: Text(
            'ERROR 404\nPage Not Found',
            textAlign: TextAlign.center,
          ),
        ),
      );
    });
  }
}
