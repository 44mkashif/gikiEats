import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:giki_eats/models/user.dart';
import 'package:giki_eats/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _databaseService = DatabaseService();

  User _userFromFirebaseUser(FirebaseUser user) {
    if(user != null){
      return User(user.uid, user.displayName, user.email, user.phoneNumber);
    }
    else {
      return null;
    }
  }




  //Auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser); //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  //Login
  Future<User> logIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } 
    catch (e) {
      print(e.message);
      return null;
    }
  }

//   register
   Future signUp(String name, String email, String phoneNumber, String password) async {
     try{
       AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
       User user = _userFromFirebaseUser(result.user);
       user.name = name;
       user.phoneNumber = phoneNumber;
       user.role = 'customer';
       _databaseService.createUser(user);
       return user;
     }
     catch(e) {
       print(e.toString());
       return null;
     }
   }

  // sign out
  Future signOut() async{
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }    
  }
}
