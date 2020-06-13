import 'package:flutter/material.dart';
import 'package:giki_eats/models/user.dart';
import 'package:giki_eats/screens/customerScreens/customerhome.dart';
import 'package:giki_eats/screens/restaurantScreens/resthome.dart';
import 'package:giki_eats/screens/welcome.dart';
import 'package:provider/provider.dart';
import 'package:giki_eats/services/auth.dart';

class Wrapper extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context){
    
    final user = Provider.of<User>(context);
    print(user);
    if(user == null){
      return WelcomePage();
    }
    else {
      User user2 = _auth.getUser(user.email);
      print(user2.toJson());
      if (user2.role == 'customer'){
        return CustomerHome(user: user2);
      }
      else{
       return RestaurantHome(user: user2);
     }
    }
  }
}