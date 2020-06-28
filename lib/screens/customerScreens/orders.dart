import 'package:flutter/material.dart';
import 'package:giki_eats/services/database.dart';
import 'package:giki_eats/utils/loader.dart';

class MyOrders extends StatelessWidget {
  final String userId;

  MyOrders({this.userId});

  @override
  Widget build(BuildContext context) {
    print('userId $userId');
    DatabaseService _db = DatabaseService(userId: userId);
    return Scaffold(
      body: StreamBuilder(
        stream: _db.ordersDataForUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('snapshot: ${snapshot.data}');
            return Container(
              child: Text('data'),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
