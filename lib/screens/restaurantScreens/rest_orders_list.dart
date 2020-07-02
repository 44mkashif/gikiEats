import 'package:flutter/material.dart';
import 'package:giki_eats/models/order.dart';
import 'package:giki_eats/utils/colors.dart';
import 'package:intl/intl.dart';

class OrdersList extends StatefulWidget {
  List<Order> orders;

  OrdersList({Key key, this.orders}) : super(key: key);

  final _OrdersListState orderListState = new _OrdersListState();

  @override
  _OrdersListState createState() => orderListState;
}

class _OrdersListState extends State<OrdersList> {
  List<Order> orders;
  @override
  Widget build(BuildContext context) {
    orders = widget.orders;
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (var order in orders)
            GestureDetector(
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
                            order.toLocation,
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
                              ]),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                order.status,
                                style: TextStyle(color: white),
                              ),
                              Text(
                                DateFormat.yMd().add_jm().format(order.orderedOn.toDate()),
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
                  )),
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/restOrderDetails', arguments: order);
              },
            )
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
