import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giki_eats/models/user.dart';
import 'package:giki_eats/screens/restaurantScreens/rest_drawer.dart';
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
    loggedInUser = widget.user;
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
                          padding: const EdgeInsets.fromLTRB(0,0,0,8),
                          child: ClipRRect(
                            child: Image.asset(
                              '${restaurant.image}',
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
                          child: Text(
                            '${restaurant.description}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: teal,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Contact: ${restaurant.phoneNumber}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: teal,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
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
                                    onTap: () => {
                                      Navigator.pushNamed(context, '/restOrders')
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
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
      drawer: RestaurantDrawer(user: widget.user)
    );
  }
}
