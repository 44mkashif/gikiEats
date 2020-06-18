import 'package:flutter/material.dart';
import 'package:giki_eats/models/order.dart';
import 'package:giki_eats/screens/restaurantScreens/rest_drawer.dart';
import 'package:giki_eats/services/auth.dart';
import 'package:giki_eats/services/database.dart';
import 'package:giki_eats/utils/colors.dart';
import 'package:giki_eats/utils/loader.dart';
import 'package:giki_eats/utils/variables.dart';

class RestaurantOrders extends StatefulWidget {
  const RestaurantOrders({Key key}) : super(key: key);
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<RestaurantOrders> {
  final AuthService _auth = AuthService();
  String titleText = 'GIKI Eats';

  @override
  Widget build(BuildContext context) {
    DatabaseService _db = DatabaseService(restaurantId: restaurant.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        centerTitle: true,
        backgroundColor: teal,
      ),
      body: StreamBuilder(
        stream: _db.ordersDataForRestaurant,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Order order = snapshot.data;
            return Text(order.id);
          } else {
            return Loading();
          }
        },
      ),
      drawer: RestaurantDrawer(user: loggedInUser)
    );
  }
}
