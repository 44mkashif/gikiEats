import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  String id;
  String name;
  String description;
  String phoneNumber;
  String image;

  Restaurant(
      this.id, this.name, this.description, this.phoneNumber, this.image);

  Restaurant.fromSnapshot(QuerySnapshot snapshot) {
    id = snapshot.documents[0].data['id'];
    name = snapshot.documents[0].data['name'];
    description = snapshot.documents[0].data['description'];
    phoneNumber = snapshot.documents[0].data['phoneNumber'];
    image = snapshot.documents[0].data['image'];
  }

  // List<Restaurant>.fromSnapshot(QuerySnapshot snapshot) {

  // }

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
