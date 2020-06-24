import 'package:cloud_firestore/cloud_firestore.dart';

class MenuItem {
  String id;
  int active;
  String name;
  int price;
  String category;
  String description;
  String image;

  MenuItem(this.id, this.active, this.name, this.price, this.category, this.description, this.image,);

  MenuItem.fromSnapshot(QuerySnapshot snapshot) {
    id = snapshot.documents[0].data['id'];
    active = snapshot.documents[0].data['active'];
    name = snapshot.documents[0].data['name'];
    price = snapshot.documents[0].data['price'];
    category = snapshot.documents[0].data['category'];
    description = snapshot.documents[0].data['description'];
    image = snapshot.documents[0].data['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'active': active,
      'name': name,
      'price': price,
      'category': category,
      'description': description,
      'image': image,
    };
  }
}
