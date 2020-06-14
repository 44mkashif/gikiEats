import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giki_eats/models/user.dart';

class DatabaseService {
  final String id;
  DatabaseService({this.id});

  //collection reference
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection("users");

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  // Future<User> getUser(String id) async {
  //   try {
  //     return _usersCollectionReference
  //         .where('id', isEqualTo: id)
  //         .getDocuments()
  //         .then((QuerySnapshot docs) {
  //       if (docs.documents.isNotEmpty) {
  //         var doc = docs.documents[0].data;
  //         User user = new User(
  //           doc['id'],
  //           doc['name'],
  //           doc['email'],
  //           doc['phoneNumber'],
  //         );
  //         user.role = doc['role'];
  //         return user;
  //       }
  //     });
  //   } catch (e) {
  //     return e.message;
  //   }
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
