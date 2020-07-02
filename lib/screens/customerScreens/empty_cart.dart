import 'package:flutter/material.dart';
import 'package:giki_eats/utils/colors.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset(
              'images/empty_cart.png',
              height: 360,
            ),
          ),
          SizedBox(height: 20,),
          Text(
            'Empty Cart',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: teal,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
            child: Text(
              'Looks like you haven\'t made your choice yet...',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
