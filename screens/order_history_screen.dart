// lib/screens/order_history_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mpemba2/screens/receipt_screen.dart';
import 'package:mpemba2/services/cart_provider.dart';
import 'package:provider/provider.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        centerTitle: true,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.orderHistory.isEmpty) {
            return const Center(
              child: Text(
                'No orders have been completed yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: cart.orderHistory.length,
            itemBuilder: (context, index) {
              final receipt = cart.orderHistory[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.receipt, color: Colors.teal),
                  title: Text('Order #${receipt.id.substring(receipt.id.length - 5)}'),
                  subtitle: Text(DateFormat('d MMM yyyy, h:mm a').format(receipt.date)),
                  trailing: Text(
                    cart.formatCurrency(receipt.total),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // Navigate to the ReceiptScreen to view the details of this specific order
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReceiptScreen(receipt: receipt),
                    ));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}