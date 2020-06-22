import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:giki_eats/models/user.dart';
import 'package:giki_eats/screens/customerScreens/customer_drawer.dart';
import 'package:giki_eats/screens/customerScreens/restaurant_list.dart';
import 'package:giki_eats/utils/colors.dart';

class CustomerHome extends StatefulWidget {
  final User user;

  const CustomerHome({Key key, this.user}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<CustomerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GIKI Eats'),
        centerTitle: true,
        backgroundColor: teal,
      ),
      backgroundColor: white,
      body: new Container(
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                alignment: Alignment.center,
                height: 45,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      size: 25,
                    ),
                    hintText: 'Find food and restaurants...',
                    contentPadding: EdgeInsets.all(6),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            //   child: CategoriesList(),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Restaurants',
                    style: TextStyle(
                      color: grey,
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: RestaurantList(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      drawer: CustomerDrawer(user: widget.user),
    );
  }
}
