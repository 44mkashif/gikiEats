import 'package:flutter/material.dart';
import 'package:giki_eats/models/user.dart';
import 'package:giki_eats/ui/home.dart';
import 'package:giki_eats/ui/welcome.dart';
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