import 'package:flutter/material.dart';
import 'package:giki_eats/utils/colors.dart';

final entries = ['A', 'B', 'C'];

class Myorders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
        iconTheme: IconThemeData(color: black),
    backgroundColor: white,
    elevation: 0.0,
          title: Text(
            'Orders',
            style: TextStyle(
              color: black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
    leading: IconButton(
    icon: Icon(Icons.close),
    onPressed: () {
    Navigator.pop(context);
    }),
    ),
      backgroundColor: white,
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                leading: Text(
                  '1000rs',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
            title: Text("Description of order"),
            subtitle: Text("1200am"),
            trailing: Text(
              'Complete',
              style: TextStyle(
                color: green,
              ),
            ),
            );
          }
      )
    );
  }
}
