import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
   String id;
   String name;
   String description;
   String phoneNumber;
   String image;

   Restaurant(this.id, this.name, this.description, this.phoneNumber, this.image);

   fromSnapshot(DocumentSnapshot snapshot){
     id = snapshot.data['id'];
     name = snapshot.data['name'];
     description = snapshot.data['description'];
     phoneNumber = snapshot.data['phoneNumber'];
     image = snapshot.data['image'];
   }


   Map<String, dynamic> toJson() {
     return {
       'id': id,
       'name': name,
       'description': description,
       'phoneNumber': phoneNumber,
       'image': image,
     };
   }
 }