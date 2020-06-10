import 'package:flutter/material.dart';
import 'package:giki_eats/models/user.dart';
import 'package:giki_eats/services/auth.dart';
import 'package:giki_eats/util/config.dart';

class Home extends StatefulWidget {
  final User user;

  const Home({Key key, this.user}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GIKI Eats'),
        backgroundColor: teal,
      ),
      body: new Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container(
                child: Text('Home'),
              ),
              RaisedButton(
                onPressed: () async {
                  await _auth.signOut();
                },
                child: Text('Logout'),
              ),
            ],
          )),
    );
  }
}
