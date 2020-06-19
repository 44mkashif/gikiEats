import 'package:flutter/material.dart';
import 'package:giki_eats/models/restaurant.dart';
import 'package:giki_eats/screens/customerScreens/customer_home.dart';
import 'package:giki_eats/screens/customerScreens/restaurant_screen.dart';
import 'package:giki_eats/screens/login.dart';
import 'package:giki_eats/screens/signup.dart';
import 'package:giki_eats/screens/welcome.dart';
import 'package:giki_eats/screens/wrapper.dart';
import 'package:giki_eats/utils/colors.dart';

import 'models/user.dart';
import 'screens/restaurantScreens/rest_home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Wrapper());

      case '/welcome':
        return MaterialPageRoute(builder: (_) => WelcomePage());

      case '/customerHome':
        if (args is User) {
          return MaterialPageRoute(
              builder: (context) => CustomerHome(user: args));
        }
        return _errorRoute();

      case '/restHome':
        if (args is User) {
          return MaterialPageRoute(
              builder: (context) => RestaurantHome(user: args));
        }
        return _errorRoute();

      case '/login':
        return MaterialPageRoute(builder: (_) => Login());

      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUp());

      case '/restaurantScreen':
        if (args is Restaurant) {
          return MaterialPageRoute(
              builder: (context) => RestaurantScreen(restaurant: args));
        }
        return _errorRoute();

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('GIKI Eats'),
        ),
        body: Container(
          alignment: Alignment.center,
          color: offwhite,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'ERROR 404!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Page Not Found',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    });
  }
}
