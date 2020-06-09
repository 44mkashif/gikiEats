import 'package:flutter/material.dart';
import 'package:giki_eats/ui/signup.dart';
import 'package:giki_eats/util/config.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // color: teal,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(0, 105, 92, 1),
              Color.fromRGBO(0, 135, 121, 1),
              Color.fromRGBO(81, 184, 160, 1),
              Color.fromRGBO(178, 224, 187, 1),
              Color.fromRGBO(253, 244, 179, 1),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Login',
                style: TextStyle(
                  color: offwhite,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: offwhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                  child: ListView(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: 'GIKI Email',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Password',
                        ),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        // padding: EdgeInsets.all(12.0),
                        child: GestureDetector(
                          onTap: () {
                            debugPrint('Reset Password');
                          },
                          child: Text(
                            'Forgot Password?',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: teal,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        height: 60.0,
                        width: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          elevation: 7.0,
                          onPressed: () {
                            debugPrint('Account Logged In...');
                          },
                          color: teal,
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: offwhite,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Don\'t have an Account?',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                var router = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new SignUp(),
                                );

                                Navigator.of(context).push(router);
                              },
                              child: Text(
                                'Create Account',
                                style: TextStyle(
                                  color: teal,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
