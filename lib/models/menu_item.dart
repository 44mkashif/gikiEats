import 'package:cloud_firestore/cloud_firestore.dart';

class MenuItem {
   String id;
   String name;
   int price;
   String category;

   MenuItem(this.id, this.name, this.price, this.category);

   fromSnapshot(DocumentSnapshot snapshot){
     id = snapshot.data['id'];
     name = snapshot.data['name'];
     price = snapshot.data['price'];
     category = snapshot.data['category'];
   }


   Map<String, dynamic> toJson() {
     return {
       'id': id,
       'name': name,
       'price': price,
       'category': category,
     };
   }
 }