// lib/services/cart_provider.dart
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mpemba2/models/cart_item.dart';
import 'package:mpemba2/models/order_receipt.dart';
import 'package:mpemba2/models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<int, CartItem> _items = {};
  final List<OrderReceipt> _orderHistory = [];

  // --- Getters for the current cart ---
  Map<int, CartItem> get items => {..._items};
  int get itemCount => _items.length;
  double get subtotal {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }
  double get discount => -20.00; // Example static discount
  double get tax => subtotal * 0.05;
  double get total => subtotal + tax + discount;

  // --- Getters for completed transaction history ---
  List<OrderReceipt> get orderHistory => _orderHistory;

  // These are now calculated from the history list for data consistency
  int get completedOrderCount => _orderHistory.length;
  double get totalSales {
    var total = 0.0;
    for (var order in _orderHistory) {
      total += order.total;
    }
    return total;
  }

  // --- Method to finalize an order ---
  void completeOrder() {
    if (items.isEmpty) return;

    // Create a receipt from the current cart state
    final newReceipt = OrderReceipt(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Simple unique ID
      items: items.values.toList(),
      subtotal: subtotal,
      tax: tax,
      discount: discount,
      total: total,
      date: DateTime.now(),
    );

    // Add the new receipt to the top of the history list
    _orderHistory.insert(0, newReceipt);

    // Clear the cart for the next order
    _items.clear();

    // Notify listeners to rebuild widgets (like HomeScreen and OrderHistoryScreen)
    notifyListeners();
  }

  // --- Other cart management methods ---
  String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_ZM', symbol: 'K', decimalDigits: 2).format(amount);
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
            (existingCartItem) => CartItem(
          product: existingCartItem.product,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
            () => CartItem(product: product),
      );
    }
    notifyListeners();
  }

  void removeItem(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void updateQuantity(int productId, int quantity) {
    if (_items.containsKey(productId)) {
      if (quantity > 0) {
        _items.update(productId, (item) => CartItem(product: item.product, quantity: quantity));
      } else {
        removeItem(productId);
      }
      notifyListeners();
    }
  }
}