import 'package:flutter/material.dart';
import 'package:giki_eats/models/order.dart';
import 'package:giki_eats/services/database.dart';
import 'package:giki_eats/utils/colors.dart';
import 'package:giki_eats/utils/loader.dart';
import 'package:giki_eats/utils/variables.dart';
import 'package:intl/intl.dart';

class MyOrders extends StatelessWidget {
  final String userId;
  DatabaseService _db;
  MyOrders({this.userId});

  @override
  Widget build(BuildContext context) {
    List<Order> orders;
    print('userId $userId');
    _db = DatabaseService(userId: userId);
    return Scaffold(
      backgroundColor: white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("My Orders",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Image.asset(
                  "images/ordersPageImage.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: StreamBuilder(
          stream: _db.ordersDataForUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              orders = snapshot.data;
              if(orders.isEmpty)
                return emptyOrders();
              return Container(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return orderContainer(orders[index]);
                  },
                ),
              );
            } else if (!snapshot.hasData) {
              return emptyOrders();
            } else {
              return Loading();
            }
          },
        ),
      ),
    );
  }

  Widget orderContainer(Order order) {
    _db =
        DatabaseService(userId: this.userId, restaurantId: order.restaurantID);
    return StreamBuilder(
      stream: _db.restaurant,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          restaurant = snapshot.data;
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Card(
                margin: const EdgeInsets.all(8),
                color: Colors.teal[300],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      isThreeLine: true,
                      contentPadding: const EdgeInsets.all(5),
                      title: Text(
                        restaurant.name,
                        style: TextStyle(color: white, fontSize: 20),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text(
                            'Items: ' + itemsQty(order).toString(),
                            style: TextStyle(color: white, fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Total: Rs.' + order.total.toString(),
                            style: TextStyle(color: white, fontSize: 16),
                          ),
                        ],
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            order.status,
                            style: TextStyle(color: white),
                          ),
                          Text(
                            DateFormat.yMd()
                                .add_jm()
                                .format(order.orderedOn.toDate()),
                            style: TextStyle(
                              color: white,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                elevation: 5,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/orderDetails', arguments: order);
            },
          );
        } else {
          return Loading();
        }
      },
    );
  }

  Widget emptyOrders() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset(
              'images/empty_cart.png',
              height: 260,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'No orders yet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: teal,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
            child: Text(
              'Looks like you haven\'t ordered anything yet...',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  int itemsQty(Order order) {
    int x = 0;
    for (var qty in order.menuQty) {
      x = x + qty;
    }
    return x;
  }
}
