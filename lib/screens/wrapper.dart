import 'package:flutter/material.dart';
import 'package:giki_eats/models/user.dart';
import 'package:giki_eats/screens/home.dart';
import 'package:giki_eats/screens/welcome.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);
    print(user);
    if(user == null){
      return WelcomePage();
    }
    else {
      return Home(user: user);
    }

  }
}