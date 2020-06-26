import 'package:flutter/material.dart';
import 'package:giki_eats/models/menu_item.dart';
import 'package:giki_eats/utils/colors.dart';
import '../../services/database.dart';
import '../../utils/loader.dart';

class MenuItemScreen extends StatefulWidget {
  final String menuItemId;
  final String restaurantId;
  const MenuItemScreen({Key key, this.restaurantId, this.menuItemId})
      : super(key: key);

  @override
  _MenuItemScreenState createState() => _MenuItemScreenState();
}

class _MenuItemScreenState extends State<MenuItemScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    DatabaseService _db = DatabaseService(
        restaurantId: widget.restaurantId, menuItemId: widget.menuItemId);

    return StreamBuilder(
      stream: _db.menuItem,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          MenuItem menuItem = snapshot.data;
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
                      IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                          color: white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/cart', arguments: [widget.restaurantId]);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  alignment: Alignment.center,
                  child: Hero(
                    tag: menuItem.name,
                    child: CircleAvatar(
                      radius: 105,
                      backgroundColor: white,
                      child: CircleAvatar(
                        radius: 103,
                        backgroundColor: teal,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: AssetImage(
                            //Todo menuitem image
                            'images/fast_food.png',
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
                                menuItem.name,
                                style: TextStyle(
                                  color: teal,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Rs. ${menuItem.price.toString()}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                menuItem.description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove_shopping_cart,
                                      color: teal,
                                    ),
                                    onPressed: () {
                                      if (quantity != 1) {
                                        setState(() {
                                          quantity -= 1;
                                          print(quantity);
                                        });
                                      }
                                    },
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    height: 60.0,
                                    width: 250,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      elevation: 7.0,
                                      onPressed: () async {
                                        print('add to cart');
                                        Navigator.of(context).pushNamed('/cart',
                                            arguments: [
                                              menuItem,
                                              quantity,
                                              widget.restaurantId
                                            ]);
                                      },
                                      color: teal,
                                      child: Text(
                                        "Add to cart",
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_shopping_cart,
                                      color: teal,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        quantity += 1;
                                        print(quantity);
                                      });
                                    },
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
