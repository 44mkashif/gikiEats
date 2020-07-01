import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:giki_eats/models/menu_item.dart';
import 'package:giki_eats/models/order.dart';
import 'package:giki_eats/models/restaurant.dart';
import 'package:giki_eats/models/user.dart';
import 'package:path/path.dart';

class DatabaseService {
  final String userId;
  final String restaurantId;
  final String menuItemId;
  final List<String> menuItems;
  DatabaseService({this.userId, this.restaurantId, this.menuItemId, this.menuItems});

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
  Future createMenu(MenuItem menuItem) async {
    try{
      await _restaurantsCollectionReference
          .document(restaurantId)
          .collection("menu")
          .add(menuItem.toJson())
          .then((value) => {
            _restaurantsCollectionReference
                .document(restaurantId)
                .collection("menu")
                .document(value.documentID)
                .updateData({
              "id": value.documentID,
            })
      });
    } catch (e) {
      return e.message;
    }
  }

  Future deleteMenuItem(String menuItemId) async {
    try {
      await _restaurantsCollectionReference
          .document(restaurantId)
          .collection("menu")
          .document(menuItemId)
          .delete();
    } catch (e) {
      return e.message;
    }
  }

  Future uploadImage(String fileName, File _image) async{

    final StorageReference storageReference = FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask storageUploadTask = storageReference.putFile(_image);
    final StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask.onComplete;
    return await storageReference.getDownloadURL();
  }

  Future createOrder(Order order) async {
    try {
      await _ordersCollectionReference.add(order.toJson()).then((value) => {
        _ordersCollectionReference.document(value.documentID).updateData({"id": value.documentID})
      });
      return true;
    } catch (e) {
      return e.message;
    }
  }

  Future changeOrderStatus(String orderId, String updatedStatus) async{
    try{
      if (updatedStatus == 'ACCEPTED'){
        await _ordersCollectionReference
        .document(orderId)
        .updateData({
          "status": updatedStatus,
          "acceptedOn": FieldValue.serverTimestamp()
        });
      }
      else{
        await _ordersCollectionReference
        .document(orderId)
        .updateData({
          "status": updatedStatus
        });
      }
      
    }catch(e){
      return e.message;
    }
  }

  Future activateMenuItem(String menuItemId) async {
    try {
      await _restaurantsCollectionReference
          .document(restaurantId)
          .collection("menu")
          .document(menuItemId)
          .updateData({
        "active": 1,
      });
    } catch (e) {
      return e.message;
    }
  }

  Future deactivateMenuItem(String menuItemId) async {
    try {
      await _restaurantsCollectionReference
          .document(restaurantId)
          .collection("menu")
          .document(menuItemId)
          .updateData({
            "active": 0,
          });
    } catch (e) {
      return e.message;
    }
  }

  Stream<List<MenuItem>> get getActivatedMenuItems {
    return _restaurantsCollectionReference
        .document(restaurantId)
        .collection("menu")
        .where('active', isEqualTo: 1)
        .snapshots()
        .map(_menuFromSnapshot);
  }

  Stream<List<MenuItem>> get getDeactivatedMenuItems {
    return _restaurantsCollectionReference
        .document(restaurantId)
        .collection("menu")
        .where('active', isEqualTo: 0)
        .snapshots()
        .map(_menuFromSnapshot);
  }

  Stream<List<Order>> get ordersDataForRestaurant {
      return _ordersCollectionReference
        .where('restaurantID', isEqualTo: restaurantId)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  Stream<List<Order>> get ordersDataForUser {
      return _ordersCollectionReference
        .where('userID', isEqualTo: userId)
        .orderBy('orderedOn', descending: true)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  Stream<List<MenuItem>> get menuItemDataForOrderDetails {
      return _restaurantsCollectionReference
        .document(restaurantId)
        .collection("menu")
        .where('id', whereIn: menuItems)
        .snapshots()
        .map(_menuFromSnapshot);
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

  Stream<Restaurant> get restaurant {
    return _restaurantsCollectionReference
        .where('id', isEqualTo: restaurantId)
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
        .where('id', isEqualTo: menuItemId)
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
        doc.data['time'],
        doc.data['deliveryFee'],
      );
    }).toList();
  }

  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Order(
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
        doc.data['active'],
        doc.data['name'],
        doc.data['price'],
        doc.data['category'],
        doc.data['description'],
        doc.data['image'],
      );
    }).toList();
  }
}
