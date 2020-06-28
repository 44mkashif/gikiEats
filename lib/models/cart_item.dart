import 'package:giki_eats/models/menu_item.dart';

class CartItem {
  MenuItem menuItem;
  String userId;
  String restaurantId;
  int total;
  int quantity;

  CartItem(this.menuItem, this.userId, this.restaurantId, this.total, this.quantity);

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
