import 'package:flutter/material.dart';
import 'package:giki_eats/models/restaurant.dart';
import 'package:giki_eats/models/user.dart';
import 'package:giki_eats/screens/customerScreens/customer_home.dart';
import 'package:giki_eats/screens/restaurantScreens/rest_home.dart';
import 'package:giki_eats/screens/welcome.dart';
import 'package:giki_eats/services/database.dart';
import 'package:giki_eats/utils/loader.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool loading = true;
  bool customer = false;
  bool restaurant = false;
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user == null) {
      return WelcomePage();
    } else {
      final DatabaseService _db = DatabaseService(userId: user.id);
      return StreamBuilder<User>(
        stream: _db.userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.role == 'customer') {
              return StreamProvider<List<Restaurant>>.value(
                value: _db.restaurants,
                child: CustomerHome(
                  user: snapshot.data,
                ),
              );
            } else if (snapshot.data.role == 'restaurant') {
              return RestaurantHome(
                user: snapshot.data,
              );
            }
          } else {
            return Loading();
          }
        },
      );
    }
  }
}
