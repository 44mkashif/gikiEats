import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  String id;
  String name;
  String description;
  String phoneNumber;
  String image;
  Map<String, dynamic> time;

  Restaurant(
      this.id, this.name, this.description, this.phoneNumber, this.image, this.time);

  Restaurant.fromSnapshot(QuerySnapshot snapshot) {
    id = snapshot.documents[0].data['id'];
    name = snapshot.documents[0].data['name'];
    description = snapshot.documents[0].data['description'];
    phoneNumber = snapshot.documents[0].data['phoneNumber'];
    image = snapshot.documents[0].data['image'];
    time = snapshot.documents[0].data['time'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'phoneNumber': phoneNumber,
      'image': image,
      'time': time,
    };
  }
}
