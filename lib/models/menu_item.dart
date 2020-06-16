import 'package:cloud_firestore/cloud_firestore.dart';

class MenuItem {
  String id;
  String name;
  int price;
  String category;

  MenuItem(this.id, this.name, this.price, this.category);

  MenuItem.fromSnapshot(QuerySnapshot snapshot) {
    id = snapshot.documents[0].data['id'];
    name = snapshot.documents[0].data['name'];
    price = snapshot.documents[0].data['price'];
    category = snapshot.documents[0].data['category'];
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
