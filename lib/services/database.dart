import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giki_eats/models/restaurant.dart';
import 'package:giki_eats/models/user.dart';

class DatabaseService {
  final String id;
  DatabaseService({this.id});

  //collection reference
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection("users");

  final CollectionReference _restaurantsCollectionReference = 
      Firestore.instance.collection("restaurants");    

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  CollectionReference getRestaurantInstance(){
    return _restaurantsCollectionReference;
  }

  // Stream<Restaurant> get restaurantData {
  //   return _restaurantsCollectionReference
  //       .where("admin", isEqualTo: id)
  //       .document()
  //       .snapshots()
  //       .map(_restaurantfromSnapshot);
  // }

  // Restaurant _restaurantfromSnapshot(DocumentSnapshot event) {
  //   Restaurant restaurant = Restaurant(
  //     event.data['id'],
  //     event.data['name'],
  //     event.data['description'],
  //     event.data['phoneNumber'],
  //     event.data['admin'],
  //     event.data['admin2']
  //   );
  //   return restaurant;
  // }

  // Future<Restaurant> getRestaurant() async{
  //   return _restaurantsCollectionReference
  //   .where('admin', isEqualTo: id)
  //   .getDocuments()
  //   .then((value) {
  //     return Restaurant(value.documents[0].data['id'], value.documents[0].data['name'], value.documents[0].data['description'],
  //     value.documents[0].data['phoneNumber'],value.documents[0].data['admin'], value.documents[0].data['admin2']);
  //   });
  // }

  Stream<User> get userData {
    return _usersCollectionReference
        .document(id)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  User _userDataFromSnapshot(DocumentSnapshot event) {
    User user = User(
      event.data['id'],
      event.data['name'],
      event.data['email'],
      event.data['phoneNumber'],
    );
    user.role = event.data['role'];
    return user;
  }
}
