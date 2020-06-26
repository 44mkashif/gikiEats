import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giki_eats/models/menu_item.dart';
import 'package:giki_eats/models/order.dart';
import 'package:giki_eats/services/database.dart';
import 'package:giki_eats/utils/colors.dart';
import 'package:giki_eats/utils/loader.dart';
import 'package:giki_eats/utils/variables.dart';

class Cart extends StatefulWidget {
  final MenuItem menuItem;
  final int quantity;
  final String restaurantId;

  const Cart({Key key, this.menuItem, this.quantity, this.restaurantId})
      : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  String userId;

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
    final ValueNotifier<int> _total = ValueNotifier<int>(0);
    if (menuIds.isEmpty && widget.menuItem == null) {
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
      if (widget.menuItem != null) {
        bool isUnique;
        if (menuIds.isEmpty && menuQty.isEmpty) {
          menuIds.insert(0, widget.menuItem.id);
          menuQty.insert(0, widget.quantity);
        } else {
          for (var menuId in menuIds) {
            if (menuId == widget.menuItem.id) {
              int index = menuIds.indexOf(menuId);
              menuQty[index] = widget.quantity;
              isUnique = false;
            } else {
              isUnique = true;
            }
          }
          if (isUnique) {
            menuIds.add(widget.menuItem.id);
            menuQty.add(widget.quantity);
          }
        }
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
                itemCount: menuQty.length,
                itemBuilder: (context, index) {
                  DatabaseService _db = DatabaseService(
                      restaurantId: widget.restaurantId,
                      menuItemId: menuIds[index]);
                  return StreamBuilder(
                    stream: _db.menuItem,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        _total.value += (snapshot.data.price * menuQty[index]);
                        print('total: $_total');
                        return menuItemContainer(snapshot.data, menuQty[index]);
                      } else {
                        return Loading();
                      }
                    },
                  );
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
                    ValueListenableBuilder<int>(
                      valueListenable: _total,
                      builder: (context, value, _) {
                        return Text(
                          value.toString(),
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
                      print('object');
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

Widget menuItemContainer(MenuItem menuItem, int quantity) {
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
            child: Hero(
              tag: menuItem.name,
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
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  menuItem.name,
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
                  'Rs. ${menuItem.price.toString()}',
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
                  'Quantity: $quantity',
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
                  'Subtotal: Rs. ${menuItem.price * quantity}',
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
                  print('delete');
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
