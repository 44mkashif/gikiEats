import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giki_eats/models/cart_item.dart';
import 'package:giki_eats/models/menu_item.dart';
import 'package:giki_eats/models/restaurant.dart';
import 'package:giki_eats/utils/colors.dart';
import 'package:giki_eats/utils/variables.dart';
import '../../services/database.dart';
import '../../utils/loader.dart';

class MenuItemScreen extends StatefulWidget {
  final String menuItemId;
  final Restaurant restaurant;
  const MenuItemScreen({Key key, this.restaurant, this.menuItemId})
      : super(key: key);

  @override
  _MenuItemScreenState createState() => _MenuItemScreenState();
}

class _MenuItemScreenState extends State<MenuItemScreen> {
  int quantity = 1;
  String userId;
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  _getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    userId = user.uid;
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService _db = DatabaseService(
        restaurantId: restaurant.id, menuItemId: widget.menuItemId);

    return StreamBuilder(
      stream: _db.menuItem,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          MenuItem menuItem = snapshot.data;
          return Scaffold(
            key: _key,
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
                          Navigator.of(context).pushNamed('/cart');
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 105,
                    backgroundColor: white,
                    child: CircleAvatar(
                      radius: 103,
                      backgroundColor: teal,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(menuItem.image),
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
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                              Container(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                                child: Text(
                                  menuItem.description,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
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
                                    width: 280,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      elevation: 7.0,
                                      onPressed: () async {
                                        CartItem cartItem = CartItem(
                                          menuItem,
                                          userId,
                                          restaurant.id,
                                          menuItem.price * quantity,
                                          quantity,
                                          restaurant.deliveryFee,
                                        );
                                        bool isUnique = true;
                                        if (cart.isEmpty) {
                                          cart.insert(0, cartItem);
                                          for (var cartItem in cart) {
                                            int index = cart.indexOf(cartItem);
                                            menuIds.insert(
                                              index,
                                              cartItem.menuItem.id,
                                            );
                                            menuQty.insert(
                                              index,
                                              cartItem.quantity,
                                            );
                                          }
                                        } else {
                                          for (var cartitem in cart) {
                                            if (isUnique) {
                                              if (cartitem.menuItem.id == cartItem.menuItem.id) {
                                                int index = cart.indexOf(cartitem);
                                                cart[index] = cartItem;
                                                isUnique = false;
                                              } else {
                                                isUnique = true;
                                              }
                                            }
                                          }
                                          if (isUnique) {
                                            cart.add(cartItem);
                                          }
                                        }
                                        _key.currentState.showSnackBar(
                                          SnackBar(
                                            content: Text("Added to Cart!"),
                                            duration: const Duration(milliseconds: 1000),
                                          ),
                                        );
                                      },
                                      color: teal,
                                      child: Text(
                                        "Add $quantity item/s to cart",
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 18,
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
