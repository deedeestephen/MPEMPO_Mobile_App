// lib/screens/receipt_screen.dart
import 'package:flutter/material.dart';
import 'package:mpemba2/models/order_receipt.dart';
import 'package:mpemba2/services/cart_provider.dart';
import 'package:provider/provider.dart';

class ReceiptScreen extends StatelessWidget {
  // Add an optional receipt parameter
  final OrderReceipt? receipt;

  const ReceiptScreen({super.key, this.receipt});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    // Determine if we are viewing a past receipt or the current cart
    final isViewingHistory = receipt != null;
    final displayItems = isViewingHistory ? receipt!.items : cart.items.values.toList();
    final displaySubtotal = isViewingHistory ? receipt!.subtotal : cart.subtotal;
    final displayTax = isViewingHistory ? receipt!.tax : cart.tax;
    final displayTotal = isViewingHistory ? receipt!.total : cart.total;
    final displayOrderId = isViewingHistory ? receipt!.id.substring(receipt!.id.length - 5) : '12345';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt Preview'),
        centerTitle: true,
        // The close button has different behavior now
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (isViewingHistory) {
              // If viewing history, just pop the screen
              Navigator.of(context).pop();
            } else {
              // If it's a new order, complete it and go home
              cart.completeOrder();
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        // Body content remains largely the same, but uses the determined display variables
        padding: const EdgeInsets.all(24.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Text('Mpepo Kitchen', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
              const Center(child: Text('TIN: 1234567890')),
              const SizedBox(height: 24),
              const Text('Order Details', style: TextStyle(fontWeight: FontWeight.bold)),
              const Divider(),
              ...displayItems.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${item.quantity}x ${item.product.name}'),
                    Text(cart.formatCurrency(item.product.price * item.quantity)),
                  ],
                ),
              )),
              const SizedBox(height: 20),
              const Text('Tax Breakdown', style: TextStyle(fontWeight: FontWeight.bold)),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('VAT (5%)'), Text(cart.formatCurrency(displayTax))],
              ),
              const Divider(thickness: 2, height: 30),
              _buildTotalRow('Subtotal', cart.formatCurrency(displaySubtotal)),
              _buildTotalRow('Total', cart.formatCurrency(displayTotal), isBold: true),
              const SizedBox(height: 30),
              Center(
                child: Column(
                  children: [
                    const Text('QR/Confirmation', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Container(
                      width: 150, height: 150, color: Colors.grey[300],
                      child: const Icon(Icons.qr_code_2, size: 100, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    const Text('Scan to confirm or pay'),
                    Text('Order #$displayOrderId'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Center(child: Text('Your satisfaction is our priority. Thank you!')),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.share), label: const Text('Share'),
                onPressed: () {},
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.download), label: const Text('Download'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: 16)),
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: 16)),
        ],
      ),
    );
  }
}