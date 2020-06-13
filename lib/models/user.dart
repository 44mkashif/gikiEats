import 'package:cloud_firestore/cloud_firestore.dart';

class User {
   String id;
   String name;
   String email;
   String phoneNumber;
   String role;

   User(this.id, this.name, this.email, this.phoneNumber);

   User.fromSnapshot(DocumentSnapshot snapshot){
     id = snapshot.data['id'];
     name = snapshot.data['name'];
     email = snapshot.data['email'];
     phoneNumber = snapshot.data['phoneNumber'];
     role = snapshot.data['role'];
   }


   Map<String, dynamic> toJson() {
     return {
       'id': id,
       'name': name,
       'email': email,
       'phoneNumber': phoneNumber,
       'role': role,
     };
   }
 }