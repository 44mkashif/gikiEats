import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giki_eats/models/menu_item.dart';
import 'package:giki_eats/models/order.dart';
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

  final CollectionReference _ordersCollectionReference =
      Firestore.instance.collection("orders");    

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Stream<Order> get ordersDataForRestaurants {
      return _ordersCollectionReference
        .where('restaurantID', isEqualTo: restaurantId)
        .snapshots()
        .map(_orderItemFromSnapshot);
  }

  Stream<User> get userData {
    return _usersCollectionReference
        .document(userId)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  Stream<Restaurant> get restaurantData {
    return _restaurantsCollectionReference
        .where('admin', arrayContains: userId)
        .snapshots()
        .map(_restaurantFromSnapshot);
  }

  Stream<MenuItem> get menuItem {
    return _restaurantsCollectionReference
        .document(restaurantId)
        .collection("menu")
        .snapshots()
        .map(_menuItemFromSnapshot);
  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    User user = User(
      snapshot.data['id'],
      snapshot.data['name'],
      snapshot.data['email'],
      snapshot.data['phoneNumber'],
    );
    user.role = snapshot.data['role'];
    return user;
  }

  Restaurant _restaurantFromSnapshot(QuerySnapshot snapshot) {
    return Restaurant(
      snapshot.documents[0].data['id'],
      snapshot.documents[0].data['name'],
      snapshot.documents[0].data['description'],
      snapshot.documents[0].data['phoneNumber'],
      snapshot.documents[0].data['image'],
    );
  }

  MenuItem _menuItemFromSnapshot(QuerySnapshot snapshot) {
    return MenuItem(
      snapshot.documents[0].data['id'],
      snapshot.documents[0].data['name'],
      snapshot.documents[0].data['price'],
      snapshot.documents[0].data['category'],
    );
  }

  Order _orderItemFromSnapshot(QuerySnapshot snapshot) {
    return Order(
      snapshot.documents[0].data['id'],
      snapshot.documents[0].data['restaurantID'],
      snapshot.documents[0].data['userID'],
      snapshot.documents[0].data['status'],
      snapshot.documents[0].data['orderedOn'],
      snapshot.documents[0].data['acceptedOn'],
      List.from(snapshot.documents[0].data['menuIDs']),
      List.from(snapshot.documents[0].data['menuQty']),
    );
  }
}
