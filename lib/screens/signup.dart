import 'package:flutter/material.dart';
import 'package:giki_eats/utils/loader.dart';
import 'package:giki_eats/services/auth.dart';
import 'package:giki_eats/utils/colors.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name, _email, _password, _phoneNumber, _confirmPass;
  final AuthService _auth = AuthService();
  bool loading = false, passMatch = false;

  @override
  Widget build(BuildContext context) {
        return loading
            ? Loading()
            : Scaffold(
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
                          'Create Account',
                          style: TextStyle(
                            color: white,
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
                            color: white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
                            child: Form(
                              key: _formKey,
                              child: ListView(
                                children: <Widget>[
                                  TextFormField(
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        return 'Name is required!';
                                      }
                                    },
                                    onSaved: (input) => _name = input,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      labelText: 'Full Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        return 'Email is required!';
                                      }
                                      Pattern pattern = r'[a-zA-Z0-9._-]+@giki.edu.pk';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(input)) {
                                        return 'Email is Incorrect. Use your GIKI email address';
                                      }
                                    },
                                    onSaved: (input) => _email = input,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      labelText: 'GIKI Email',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        return 'Phone Number is required!';
                                      }
                                    },
                                    onSaved: (input) => _phoneNumber = input,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.phone),
                                      labelText: 'Phone Number',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    validator: (input) {
                                      if (input.length < 6) {
                                        return "Password must be at least 6 characters long!";
                                      }
                                    },
                                    onSaved: (input) => _password = input,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      labelText: 'Password',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    validator: (input) {
                                      if (input.length < 6) {
                                        return "Password must be at least 6 characters long!";
                                      }
                                      if (input != _password) {
                                        return "Passwords do not match!";
                                      }
                                    },
                                    onSaved: (input) => _confirmPass = input,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      labelText: 'Confirm Password',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                      ),
                                    ),
                                  ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 60.0,
                                width: double.infinity,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  elevation: 7.0,
                                  onPressed: signUp,
                                  color: teal,
                                  child: Text(
                                    "Create Account",
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Already have an Account?',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed('/login');
                                      },
                                      child: Text(
                                        'Login',
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
                    ),
                  )
                ],
              ),
            ),
          );
  }

  void signUp() async {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      
      dynamic result =
          await _auth.signUp(_name, _email, _phoneNumber, _password);

      if (result == null) {
        setState(() => loading = false);
        print('Error Signing up..');
      } else {
        Navigator.pop(context);
      }
    }
  }
}
