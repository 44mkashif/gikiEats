import 'package:flutter/material.dart';
import 'package:giki_eats/utils/config.dart';

class AdminSignIn extends StatefulWidget {
  @override
  _AdminSignInState createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'GIKI Eats',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          backgroundColor: teal,
        ),
        body: Container(
            width: double.infinity,
            color: white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,100,0,0),
                  child: Text(
                    'Admin Sign In',
                    style: TextStyle(
                      fontSize: 18,
                      color: teal,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: 50,
                            padding: EdgeInsets.fromLTRB(0,4,0,0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                hintText: 'Email',
                                border: InputBorder.none,

                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            padding: EdgeInsets.fromLTRB(0,4,0,0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                hintText: 'Password',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          Container(
                              height: 60,
                              width: double.infinity,
                              child: RaisedButton(
                                elevation: 7.0,
                                color: teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                onPressed: () => debugPrint('pressed'),
                                child: Text(
                                  'Log In',
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: offwhite,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                          ),
                        ],
                      )
                  ),
                ),
              ],
            )));
  }
}
