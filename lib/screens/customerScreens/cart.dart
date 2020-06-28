import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giki_eats/models/cart_item.dart';
import 'package:giki_eats/models/menu_item.dart';
import 'package:giki_eats/models/order.dart';
import 'package:giki_eats/services/database.dart';
import 'package:giki_eats/utils/colors.dart';
import 'package:giki_eats/utils/loader.dart';
import 'package:giki_eats/utils/variables.dart';

class Cart extends StatefulWidget {
  final CartItem cartItem;

  const Cart({Key key, this.cartItem}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  int totalAmount = 0;
  DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    // ValueNotifier<int> _total = ValueNotifier<int>(0);
    int _total = 0;
    if (cart.isEmpty && widget.cartItem == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Text('Your cart is empty'),
        ),
      );
    } else {
      menuIds = [];
      menuQty = [];
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
      //Calculate Total Amount
      for (var cartItem in cart) {
        print('cartItem: ${cartItem.toJson()}');
        _total += cartItem.total;
      }

      return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  return menuItemContainer(context, cart[index]);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Total: ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    FutureBuilder(
                      future: Future.delayed(
                          const Duration(milliseconds: 500), () {}),
                      builder: (context, snapshot) {
                        return Text(
                          _total.toString(),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: teal,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 60.0,
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 7.0,
                    onPressed: () {
                      print('Place order');
                      //Todo: Inout Location
                      for (var index = 0; index < menuIds.length; index++) {
                        print(
                            'menuId: $index ${menuIds[index]}  menuQty: $index ${menuQty[index]}');
                      }
                      Order order = Order(
                        cart[0].restaurantId,
                        cart[0].userId,
                        'ORDERED',
                        'Hostel 3',
                        _total,
                        Timestamp.now(),
                        null,
                        menuIds,
                        menuQty,
                      );
                      _db.createOrder(order);
                      cart = [];
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            title: new Text("Order Placed"),
                            content: new Text(
                                "Your order has been placed successfully"),
                            actions: <Widget>[
                              // usually buttons at the bottom of the dialog
                              new FlatButton(
                                child: new Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacementNamed(
                                      context, '/cart');
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    color: teal,
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                        color: white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}

Widget menuItemContainer(BuildContext context, CartItem cartItem) {
  return Card(
    margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
    elevation: 4,
    shadowColor: grey,
    color: offwhite,
    child: Container(
      padding: EdgeInsets.fromLTRB(15, 12, 15, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: CircleAvatar(
              radius: 55,
              backgroundColor: teal,
              child: CircleAvatar(
                radius: 52,
                backgroundColor: white,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    //Todo menuitem image
                    'images/fast_food.png',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  cartItem.menuItem.name,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: teal,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Rs. ${cartItem.menuItem.price.toString()}',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Quantity: ${cartItem.quantity}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Subtotal: Rs. ${cartItem.total}',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text("Remove Item"),
                        content: new Text(
                            "Are you sure you want to remove this item from the cart."),
                        actions: <Widget>[
                          new RaisedButton(
                            child: new Text("Yes"),
                            color: Colors.red,
                            onPressed: () {
                              Navigator.of(context).pop();
                              int index = cart.indexOf(cartItem);
                              cart.removeAt(index);
                              Navigator.pushReplacementNamed(context, '/cart');
                            },
                          ),
                          new RaisedButton(
                            child: new Text("Close"),
                            color: teal,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }),
          )
        ],
      ),
    ),
  );
}

// FirebaseUser user = await FirebaseAuth.instance.currentUser();
// Order order = Order(
//   orderId,
//   widget.restaurantId,
//   user.uid,
//   'ORDERED',
//   'Hostel 3',
//   quantity,
//   Timestamp.now(),
//   null,
//   menuIDs,
//   menuQty,
// );
