import 'package:flutter/material.dart';
import 'package:giki_eats/models/restaurant.dart';
import 'package:giki_eats/utils/colors.dart';
import 'package:giki_eats/utils/loader.dart';
import 'package:provider/provider.dart';

import '../../utils/variables.dart';

class RestaurantList extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  @override
  Widget build(BuildContext context) {
    restaurants = Provider.of<List<Restaurant>>(context);
    if (restaurants != null) {
      return Column(
        children: <Widget>[
          for (var restaurant in restaurants)
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
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
                        child: Text(
                          restaurant.name,
                          style: TextStyle(
                            color: white,
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0, 3),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/restaurantScreen', arguments: restaurant.id);
              },
            ),
        ],
      );
    } else {
      return Loading();
    }
  }
}
