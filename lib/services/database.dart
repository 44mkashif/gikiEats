 import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:giki_eats/models/user.dart';

 class DatabaseService {
   //collection reference
   final CollectionReference _usersCollectionReference =
       Firestore.instance.collection("users");

   Future createUser(User user) async {
     try {
       await _usersCollectionReference.document(user.id).setData(user.toJson());
     } catch (e) {
       return e.message;
     }
   }
 }