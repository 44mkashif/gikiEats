import 'package:giki_eats/models/menu_item.dart';

class CartItem {
  MenuItem menuItem;
  String userId;
  String restaurantId;
  int total;
  int quantity;

  CartItem(this.menuItem, this.userId, this.restaurantId, this.total, this.quantity);
  // MenuItem.fromSnapshot(QuerySnapshot snapshot) {
  //   id = snapshot.documents[0].data['id'];
  //   active = snapshot.documents[0].data['active'];
  //   name = snapshot.documents[0].data['name'];
  //   price = snapshot.documents[0].data['price'];
  //   category = snapshot.documents[0].data['category'];
  //   description = snapshot.documents[0].data['description'];
  //   image = snapshot.documents[0].data['image'];
  // }

  Map<String, dynamic> toJson() {
    return {
      'menuItem': menuItem,
      'userId': userId,
      'restaurantId': restaurantId,
      'total': total,
      'quantity': quantity,
    };
  }
}
