import 'package:flutter/material.dart';
import 'package:giki_eats/services/database.dart';
import 'package:giki_eats/utils/colors.dart';
import 'package:giki_eats/utils/loader.dart';
import 'package:giki_eats/utils/variables.dart';

class RestaurantInfo extends StatelessWidget {
  final String restaurantId;
  const RestaurantInfo({Key key, this.restaurantId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DatabaseService _db = DatabaseService(restaurantId: restaurantId);
    return StreamBuilder(
      stream: _db.restaurant,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          restaurant = snapshot.data;
          return Scaffold(
            backgroundColor: teal,
            body: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      BackButton(
                        color: white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  alignment: Alignment.center,
                  child: Hero(
                    tag: "menuItem.name",
                    child: CircleAvatar(
                      radius: 105,
                      backgroundColor: white,
                      child: CircleAvatar(
                        radius: 103,
                        backgroundColor: teal,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: AssetImage(
                            restaurant.image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                      child: ListView(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                restaurant.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: teal,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                restaurant.description,
                                // textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.phone_android,
                                    color: teal,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    restaurant.phoneNumber,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.timer,
                                    color: teal,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    '${restaurant.time['open']} - ${restaurant.time['close']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.attach_money,
                                    color: teal,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    'Rs. ${restaurant.deliveryFee} per delivery',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
  }
}
