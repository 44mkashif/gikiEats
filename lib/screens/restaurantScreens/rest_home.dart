import 'package:flutter/material.dart';
import 'package:giki_eats/models/menu_item.dart';
import 'package:giki_eats/models/restaurant.dart';
import 'package:giki_eats/models/user.dart';
import 'package:giki_eats/services/auth.dart';
import 'package:giki_eats/utils/colors.dart';
import 'package:giki_eats/services/database.dart';
import 'package:giki_eats/utils/variables.dart';

class RestaurantHome extends StatefulWidget {
  final User user;

  const RestaurantHome({Key key, this.user}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<RestaurantHome> {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GIKI Eats'),
        centerTitle: true,
        backgroundColor: teal,
      ),
      body: StreamBuilder (
        stream: _db.getRestaurantInstance().where('admin', arrayContains: widget.user.id).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('Loading Data.. Please Wait..');
          restaurant = Restaurant(snapshot.data.documents[0]['id'], snapshot.data.documents[0]['name'], snapshot.data.documents[0]['description'], snapshot.data.documents[0]['phoneNumber']);

          return StreamBuilder(
            stream: _db.getRestaurantInstance().document(restaurant.id).collection("menu").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('Loading Data.. Please Wait..');
                menu = [MenuItem(snapshot.data.documents[0]['id'], snapshot.data.documents[0]['name'], snapshot.data.documents[0]['price'], snapshot.data.documents[0]['category'])];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                //restaurant contains the restaurant of which it is admin. Use it to create homescreen
                                                //menu list contains all the menu items of this restaurant
                                                //They both are global variables stored in variables.dart
                  children: <Widget>[
                    Text(restaurant.name, textAlign: TextAlign.center),
                    Text(restaurant.description, textAlign: TextAlign.center),
                    Text(restaurant.phoneNumber, textAlign: TextAlign.center),
                    Text(menu[0].name, textAlign: TextAlign.center),
                  ],
                );
            }         
            
          );
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('${widget.user.name}'),
              accountEmail: Text('${widget.user.email}'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: offwhite,
                child: Text(
                  "A",
                  style: TextStyle(
                    fontSize: 40.0,
                    color: teal
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: teal
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Divider(
              height: 1,
              color: Colors.grey,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Divider(
              height: 1,
              color: Colors.grey,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('My Orders'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Divider(
              height: 1,
              color: Colors.grey,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Divider(
              height: 1,
              color: Colors.grey,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
