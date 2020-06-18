import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giki_eats/models/user.dart';
import 'package:giki_eats/services/auth.dart';
import 'package:giki_eats/utils/colors.dart';
import 'package:giki_eats/services/database.dart';
import 'package:giki_eats/utils/loader.dart';
import 'package:giki_eats/utils/variables.dart';

class RestaurantHome extends StatefulWidget {
  final User user;

  const RestaurantHome({Key key, this.user}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<RestaurantHome> {
  final AuthService _auth = AuthService();
  String titleText = 'GIKI Eats';

  @override
  Widget build(BuildContext context) {
    DatabaseService _db = DatabaseService(userId: widget.user.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        centerTitle: true,
        backgroundColor: teal,
      ),
      body: StreamBuilder(
        stream: _db.restaurantData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            restaurant = snapshot.data;
            titleText = restaurant.name;
            print('restaurant: ${restaurant.toJson()}');
            //Reinstatiated db instance to get the restaurant id
            _db = DatabaseService(userId: widget.user.id, restaurantId: restaurant.id);
            return StreamBuilder(
              stream: _db.menuItem,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  menu = [snapshot.data];
                  print('menuItem: ${menu[0].toJson()}');
                  return Container(
                    color: Colors.grey[300],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            child: Image.asset(
                              '${restaurant.image}',
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            '${restaurant.description}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: teal,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: teal,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: ClipRRect(
                                          child: Image.asset(
                                            "images/menu.png",
                                            color: white,
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () => print('View Menu...'),
                                  ),

                                  SizedBox(
                                    width: 40,
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          color: teal,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(
                                        child: ClipRRect(
                                          child: Image.asset(
                                            "images/order.png",
                                            color: white,
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () => print('View Order...'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Menu',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: teal,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Orders',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: teal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Contact: ${restaurant.phoneNumber}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    color: teal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Loading();
                }
              },
            );
          } else {
            return Loading();
          }
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('${widget.user.name}'),
              accountEmail: Text('${widget.user.email}'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: white,
                child: Text(
                  "${widget.user.name[0]}",
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
