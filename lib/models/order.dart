import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
   String id;
   String restaurantID;
   String userID;
   String status;
   Timestamp orderedOn;
   Timestamp acceptedOn;
   List<String> menuIDs;
   List<int> menuQty;

   Order(this.id, this.restaurantID, this.userID, this.status, this.orderedOn, this.acceptedOn, this.menuIDs, this.menuQty);

   fromSnapshot(DocumentSnapshot snapshot){
     id = snapshot.data['id'];
     restaurantID = snapshot.data['restaurantID'];
     userID = snapshot.data['userID'];
     status = snapshot.data['status'];
     orderedOn = snapshot.data['orderedOn'];
     acceptedOn = snapshot.data['acceptedOn'];
     menuIDs = List.from(snapshot.data['menuIDs']);
     menuQty = List.from(snapshot.data['menuQty']);
   }


   Map<String, dynamic> toJson() {
     return {
       'id': id,
       'restaurantID': restaurantID,
       'userID': userID,
       'status': status,
       'orderedOn': orderedOn,
       'acceptedOn': acceptedOn,
       'menuIDs': menuIDs.toString(),
       'menuQty': menuQty.toString()
     };
   }
 }