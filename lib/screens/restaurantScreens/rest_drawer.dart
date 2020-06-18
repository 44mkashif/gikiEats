import 'package:flutter/material.dart';
import 'package:giki_eats/models/user.dart';
import 'package:giki_eats/services/auth.dart';
import 'package:giki_eats/utils/colors.dart';

class RestaurantDrawer extends StatelessWidget {
  final User user;  
  RestaurantDrawer({Key key, this.user}) : super(key: key);
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('${user.name}'),
            accountEmail: Text('${user.email}'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: white,
              child: Text(
                "${user.name[0]}",
                style: TextStyle(fontSize: 40.0, color: teal),
              ),
            ),
            decoration: BoxDecoration(color: teal),
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
    );
  }
}
