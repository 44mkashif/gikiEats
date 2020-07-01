import 'package:giki_eats/models/menu_item.dart';

class CartItem {
  MenuItem menuItem;
  String userId;
  String restaurantId;
  int total;
  int quantity;
  int deliveryFee;

  CartItem(this.menuItem, this.userId, this.restaurantId, this.total, this.quantity, this.deliveryFee);

  Map<String, dynamic> toJson() {
    return {
      'menuItem': menuItem,
      'userId': userId,
      'restaurantId': restaurantId,
      'total': total,
      'quantity': quantity,
      'deliveryFee': deliveryFee,
    };
  }
}
