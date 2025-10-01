// lib/services/api_service.dart
import 'package:mpemba2/models/product.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

class ApiService {
  // final String _baseUrl = "http://10.0.2.2:8000"; // For Android Emulator

  // --- MOCK DATA ---
  // Replace this with the real API call below when your backend is ready.
  Future<List<Product>> getProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return _mockProducts;
  }

// --- REAL API CALL ---
/*
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products/'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
  */
}

// Sample product data based on the images.
final List<Product> _mockProducts = [
  Product(id: 1, name: 'Ugali', price: 40.00, category: 'Sides', imageUrl: 'https://i.imgur.com/w1uGwoA.jpeg'),
  Product(id: 2, name: 'Grilled Chicken', price: 85.00, category: 'Mains', imageUrl: 'https://i.imgur.com/gK5z3wV.jpeg'),
  Product(id: 3, name: 'Chapati', price: 15.00, category: 'Sides', imageUrl: 'https://i.imgur.com/yVqJ4jX.jpeg'),
  Product(id: 4, name: 'Chips', price: 20.00, category: 'Sides', imageUrl: 'https://i.imgur.com/8h2sCgA.jpeg'),
  Product(id: 5, name: 'Sukuma Wiki', price: 25.00, category: 'Sides', imageUrl: 'https://i.imgur.com/Y1Z2cZu.jpeg'),
  Product(id: 6, name: 'Berry Juice', price: 30.00, category: 'Drinks', imageUrl: 'https://i.imgur.com/L1dFqE5.jpeg'),
  Product(id: 7, name: 'Spicy Beef', price: 79.90, category: 'Mains', imageUrl: 'https://i.imgur.com/9v4n3hC.jpeg'),
  Product(id: 8, name: 'Vegetable Curry', price: 99.90, category: 'Mains', imageUrl: 'https://i.imgur.com/a4wzL0p.jpeg'),
  Product(id: 9, name: 'Grilled Tilapia', price: 150.00, category: 'Mains', imageUrl: 'https://i.imgur.com/FwV3c3q.jpeg'),
  Product(id: 10, name: 'Kachumbari', price: 30.00, category: 'Sides', imageUrl: 'https://i.imgur.com/3s1kO2d.jpeg'),
  Product(id: 11, name: 'Family Platter', price: 450.00, category: 'Platter', imageUrl: 'https://i.imgur.com/6X7x0Zt.jpeg'),
  Product(id: 12, name: 'Coca-Cola', price: 10.00, category: 'Drinks', imageUrl: 'https://i.imgur.com/pBq2pbr.jpeg'),
];