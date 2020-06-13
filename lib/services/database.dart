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

   Future<User> getUser(String emaill) async {
     try{
       return _usersCollectionReference.where('email', isEqualTo: emaill).getDocuments().then((QuerySnapshot docs) {
         if(docs.documents.isNotEmpty){
           var doc = docs.documents[0].data;
           User user = new User(doc['id'], doc['name'], doc['email'], doc['phoneNumber']);
           user.role = doc['role'];
           return user;
         }
       });
     } catch (e) {
       return e.message;
     }
   }
 }