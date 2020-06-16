import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:giki_eats/models/restaurant.dart';
import 'package:giki_eats/models/user.dart';
import 'package:giki_eats/services/auth.dart';
import 'package:giki_eats/utils/colors.dart';
import 'package:giki_eats/utils/loader.dart';
import 'package:giki_eats/utils/variables.dart';
import 'package:provider/provider.dart';

class CustomerHome extends StatefulWidget {
  final User user;

  const CustomerHome({Key key, this.user}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<CustomerHome> {
  final AuthService _auth = AuthService();
  
  @override
  Widget build(BuildContext context) {
    restaurants = Provider.of<List<Restaurant>>(context);
    if (restaurants != null) {
      for (var rest in restaurants) {
        print('rest: ${rest.toJson()}');
      }

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
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Container(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Stack(
                                  children: <Widget>[
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Loading(),
                                      ),
                                    ),
                                    Center(
                                      child: Image.asset(
                                        categories[index]['image'],
                                        fit: BoxFit.cover,
                                        height: 150,
                                        width: 230,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 160,
                                width: 230,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  // color: Colors.black.withOpacity(0.4),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.6),
                                      Colors.black.withOpacity(0.5),
                                      Colors.black.withOpacity(0.5),
                                      Colors.black.withOpacity(0.4),
                                      Colors.black.withOpacity(0.1),
                                      Colors.black.withOpacity(0.1),
                                      Colors.black.withOpacity(0.025),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    categories[index]['name'],
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          print('Category item clicked');
                        },
                      );
                    },
                  ),
                ),
              ),
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
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Column(
                        children: <Widget>[
                          for (var restaurant in restaurants)
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Stack(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Loading(),
                                            ),
                                          ),
                                          Center(
                                            child: Image.asset(
                                              restaurant.image,
                                              fit: BoxFit.cover,
                                              height: 260,
                                              // width: 400,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 260,
                                      // width: 230,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        // color: Colors.black.withOpacity(0.4),
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.6),
                                            Colors.black.withOpacity(0.5),
                                            Colors.black.withOpacity(0.5),
                                            Colors.black.withOpacity(0.4),
                                            Colors.black.withOpacity(0.1),
                                            Colors.black.withOpacity(0.1),
                                            Colors.black.withOpacity(0.025),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          restaurant.name,
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                print('Restaurant clicked');
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
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
                    "A",
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
        ),
      );
    } else {
      return Loading();
    }
  }
}
