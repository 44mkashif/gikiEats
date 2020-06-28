import 'package:giki_eats/models/cart_item.dart';
import 'package:giki_eats/models/menu_item.dart';
import 'package:giki_eats/models/restaurant.dart';
import 'package:giki_eats/models/user.dart';

User loggedInUser;
List<MenuItem> menu;
Restaurant restaurant;
List<Restaurant> restaurants;
List<Map<String, String>> categories = [
  {'name': 'Desi', 'image': 'images/desi_food.jpg'},
  {'name': 'Fast Food', 'image': 'images/fast_food.png'},
  {'name': 'Chinese', 'image': 'images/chinese_food.jpg'},
];
List<CartItem> cart = [];
List<String> menuIds = [];
List<int> menuQty = [];