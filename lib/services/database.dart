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

  Stream<List<Order>> get ordersDataForRestaurant {
      return _ordersCollectionReference
//   Stream<Order> get ordersDataForRestaurant {
//     return _ordersCollectionReference
        .where('restaurantID', isEqualTo: restaurantId)
        .snapshots()
        .map(_orderListFromSnapshot);
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

  Stream<List<MenuItem>> get menu {
    return _restaurantsCollectionReference
        .document(restaurantId)
        .collection("menu")
        .snapshots()
        .map(_menuFromSnapshot);
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
        doc.data['image'],
      );
    }).toList();
  }

  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Order(
          doc.data['id'],
          doc.data['restaurantID'],
          doc.data['userID'],
          doc.data['status'],
          doc.data['toLocation'],
          doc.data['total'],
          doc.data['orderedOn'],
          doc.data['acceptedOn'],
          List.from(doc.data['menuIDs']),
          List.from(doc.data['menuQty'])
      );
    }).toList();
  }

  List<MenuItem> _menuFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return MenuItem(
        doc.data['id'],
        doc.data['name'],
        doc.data['price'],
        doc.data['category'],
        doc.data['description'],
      );
    }).toList();
  }
}
