// lib/models/order_receipt.dart
import 'package:mpemba2/models/cart_item.dart';

class OrderReceipt {
  final String id;
  final List<CartItem> items;
  final double subtotal;
  final double tax;
  final double discount;
  final double total;
  final DateTime date;

  OrderReceipt({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.discount,
    required this.total,
    required this.date,
  });
}