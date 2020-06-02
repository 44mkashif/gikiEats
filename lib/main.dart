import 'package:flutter/material.dart';
import 'package:giki_eats/ui/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //To remove debug banner
      debugShowCheckedModeBanner: false, 
      title: 'GIKI Eats',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: new Home(),
    );
  }
}