import 'package:flutter/material.dart';
import 'package:giki_eats/ui/welcome.dart';
import 'package:giki_eats/util/config.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //To remove debug banner
      debugShowCheckedModeBanner: false,
      title: 'GIKI Eats',
      home: new WelcomePage(),
      theme: ThemeData(
        primaryColor: teal,
      ),
    );
  }
}
