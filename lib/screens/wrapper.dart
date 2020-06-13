import 'package:flutter/material.dart';
import 'package:giki_eats/models/user.dart';
import 'package:giki_eats/screens/customerScreens/customerhome.dart';
import 'package:giki_eats/screens/restaurantScreens/resthome.dart';
import 'package:giki_eats/screens/welcome.dart';
import 'package:giki_eats/services/database.dart';
import 'package:giki_eats/utils/loader.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final DatabaseService _db = DatabaseService();
  bool loading = true;
  bool customer = false;
  bool restaurant = false;
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user == null) {
      return WelcomePage();
    } else {
      Future<User> userFromDb = _db.getUser(user.email);
      if (userFromDb != null) {
        userFromDb.then(
          (userFromDb) {
            setState(() {
              user = userFromDb;
              loading = false;
              if (userFromDb.role == 'customer') {
                customer = true;
                restaurant = false;
              } else if(user.role == 'restaurant') {
                customer = false;
                restaurant = true;
              }
            });
          },
        );
      }
      if (loading) {
        return Loading();
      } else if(customer) {
        return CustomerHome(user: user);
      } else if(restaurant) {
        return RestaurantHome(user: user);
      }
    }
  }
}
