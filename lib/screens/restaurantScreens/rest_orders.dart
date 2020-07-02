import 'package:flutter/material.dart';
import 'package:giki_eats/models/order.dart';
import 'package:giki_eats/screens/restaurantScreens/rest_orders_list.dart';
import 'package:giki_eats/services/database.dart';
import 'package:giki_eats/utils/colors.dart';
import 'package:giki_eats/utils/loader.dart';
import 'package:giki_eats/utils/variables.dart';

class RestaurantOrders extends StatefulWidget {
  const RestaurantOrders({Key key}) : super(key: key);
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<RestaurantOrders> {
  String titleText = 'Orders';
  List<Order> orders, ordersList;
  OrdersList list;
  int filter = 0;
  @override
  Widget build(BuildContext context) {
    DatabaseService _db = DatabaseService(restaurantId: restaurant.id);
    return Scaffold(
      backgroundColor: white,
      body: StreamBuilder(
        stream: _db.ordersDataForRestaurant,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            orders = snapshot.data;
            orders.removeWhere((Order order) => order.status == 'CANCELED');
            ordersList = orders;
            switch(filter){
              case 1: 
                    ordersList.retainWhere((Order order) => order.status == 'ORDERED');
                    break;
              case 2: 
                    ordersList.retainWhere((Order order) => order.status == 'ACCEPTED');
                    break;
              case 3: 
                    ordersList.retainWhere((Order order) => order.status == 'REJECTED');
                    break;
              default:
                    break;      
            }
            list = OrdersList(orders: ordersList);
            return NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text("Restaurant's Orders",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )),
                        background: Image.asset(
                          "images/ordersPageImage.jpg",
                          fit: BoxFit.cover,
                        )),
                  ),
                ];
              },
              body: list
            );
          } else {
            return Loading();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_list),
        onPressed: () { showAlertDialog(context); },
      ),
    );
  }
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget newOrders = FlatButton(
      child: Text("Newly Placed"),
      onPressed:  () {
        filter = 1;
        Navigator.of(context).pop();
        reset();
      },
    );
    Widget accepted = FlatButton(
      child: Text("Accepted"),
      onPressed:  () {
        filter = 2;
        Navigator.of(context).pop();
        reset();
      },
    );
    Widget rejected = FlatButton(
      child: Text("Rejected"),
      onPressed:  () {
        filter = 3;
        Navigator.of(context).pop();
        reset();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Filter Orders"),
      content: Text("Which orders are to be displayed?"),
      actions: [
        newOrders,
        accepted,
        rejected,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  reset(){
    setState(() {});
  }
}
