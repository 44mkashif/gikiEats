import 'package:flutter/material.dart';
import 'package:giki_eats/models/menu_item.dart';
import 'package:giki_eats/screens/customerScreens/customer_home.dart';
import 'package:giki_eats/screens/customerScreens/menu_item_screen.dart';
import 'package:giki_eats/screens/customerScreens/restaurant_screen.dart';
import 'package:giki_eats/screens/login.dart';
import 'package:giki_eats/screens/restaurantScreens/add_menu.dart';
import 'package:giki_eats/screens/restaurantScreens/rest_menu.dart';
import 'package:giki_eats/screens/restaurantScreens/rest_orders.dart';
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

      case '/restOrders':
        return MaterialPageRoute(builder: (_) => RestaurantOrders());

      case '/restMenu':
        return MaterialPageRoute(builder: (_) => RestaurantMenu());

      case '/addMenu':
        return MaterialPageRoute(builder: (_) => AddMenu());

      case '/restaurantScreen':
        if (args is String) {
          return MaterialPageRoute(
              builder: (context) => RestaurantScreen(restaurantId: args));
        }
        return _errorRoute();

      case '/menuItemScreen':
        List<String> arguments = args;
        if (arguments[0] is String && arguments[1] is String) {
          return MaterialPageRoute(
              builder: (context) => MenuItemScreen(restaurantId: arguments[0],menuItemId: arguments[1]));
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
