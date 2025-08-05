import 'package:flutter/material.dart';
import '../services/api_client.dart';

class Product {
  final String id;
  final String name;
  final double weight;
  final String carat;
  final double price;
  final Color caratColor;

  Product({
    required this.id,
    required this.name,
    required this.weight,
    required this.carat,
    required this.price,
    required this.caratColor,
  });

  // Factory constructor to create Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      weight: json['weight'],
      carat: json['carat'],
      price: json['price'],
      caratColor: Color(json['caratColor']),
    );
  }
}

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String _error = '';

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final apiClient = ApiClient();
      final productData = await apiClient.getProducts();
      _products = productData.map((data) => Product.fromJson(data)).toList();
    } catch (e) {
      _error = 'Failed to fetch products';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
