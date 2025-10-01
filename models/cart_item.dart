// lib/models/cart_item.dart
import 'package:mpemba2/models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}