import 'package:flutter/material.dart';
import 'package:giki_eats/models/user.dart';
import 'package:giki_eats/services/auth.dart';
import 'package:giki_eats/ui/wrapper.dart';
import 'package:giki_eats/util/config.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        //To remove debug banner
        debugShowCheckedModeBanner: false,
        title: 'GIKI Eats',
        home: new Wrapper(),
        theme: ThemeData(
          primaryColor: teal,
        ),
      ),
    );
  }
}
