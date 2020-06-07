import 'package:flutter/material.dart';
import 'package:giki_eats/ui/signup.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
            child: Text(
              'GIKI Eats',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 44.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 280.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(34.0, 0.0, 34.0, 0.0),
            child: Container(
              height: 60.0,
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  // side: BorderSide(
                  //   color: Colors.teal,
                  // ),
                ),
                elevation: 7.0,
                onPressed: () {},
                color: Colors.teal,
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 60.0,
            child: Text(
              'OR',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(34.0, 0.0, 34.0, 0.0),
            child: Container(
              height: 60.0,
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  // side: BorderSide(
                  //   color: Colors.teal,
                  // ),
                ),
                elevation: 7.0,
                onPressed: () {
                  var router = new MaterialPageRoute(
                    builder: (BuildContext context) => new SignUp(),
                  );

                  Navigator.of(context).push(router);
                },
                color: Colors.white,
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
