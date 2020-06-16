import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giki_eats/models/menu_item.dart';
import 'package:giki_eats/models/restaurant.dart';
import 'package:giki_eats/models/user.dart';

class DatabaseService {
  final String userId;
  final String restaurantId;
  DatabaseService({this.userId, this.restaurantId});

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

  Stream<User> get userData {
    return _usersCollectionReference
        .document(userId)
        .snapshots()
        .map((snapshot) => User.fromSnapshot(snapshot));
  }

  Stream<List<Restaurant>> get restaurants {
    return _restaurantsCollectionReference
    .snapshots()
    .map(_restaurantListFromSnapshot);
  }

  Stream<Restaurant> get restaurantData {
    return _restaurantsCollectionReference
        .where('admin', arrayContains: userId)
        .snapshots()
        .map((snapshot) => Restaurant.fromSnapshot(snapshot));
  }

  Stream<MenuItem> get menuItem {
    return _restaurantsCollectionReference
        .document(restaurantId)
        .collection("menu")
        .snapshots()
        .map((snapshot) => MenuItem.fromSnapshot(snapshot));
  }

  List<Restaurant> _restaurantListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Restaurant(
          doc.data['id'],
          doc.data['name'],
          doc.data['description'],
          doc.data['phoneNumber'],
          doc.data['image']);
    }).toList();
  }
}
