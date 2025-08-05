import 'package:dio/dio.dart';
import '../utils/secure_storage.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late Dio _dio;
  
  factory ApiClient() {
    return _instance;
  }
  
  ApiClient._internal() {
    _dio = Dio();
    _dio.options.baseUrl = 'https://api.goldex.com/v1';
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    
    // Add interceptors
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add auth token to requests
        final token = await SecureStorage.readToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Handle successful responses
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        // Handle errors
        return handler.next(e);
      },
    ));
  }
  
  Dio get dio => _dio;
  
  // Mock API methods
  Future<Map<String, dynamic>> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Mock response
    return {
      'success': email == SecureStorage.defaultEmail && password == SecureStorage.defaultPassword,
      'token': 'mock_token_12345',
      'user': {
        'email': email,
        'name': 'Admin User',
      }
    };
  }
  
  Future<List<Map<String, dynamic>>> getWalletData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Mock response
    return [
      {
        'id': '24k',
        'type': 'Gold Wallet',
        'carat': '24K Pure',
        'balance': 1.25,
        'value': 6559.75,
        'todayChange': 52.48,
        'todayChangePercentage': 0.8,
        'gradientStart': 0xFFF6E27A,
        'gradientEnd': 0xFFD4AF37,
        'canRedeem': true,
      },
      {
        'id': '22k',
        'type': 'Gold Wallet',
        'carat': '22K',
        'balance': 0.5,
        'value': 2405.25,
        'todayChange': 16.84,
        'todayChangePercentage': 0.7,
        'gradientStart': 0xFFF5D76E,
        'gradientEnd': 0xFFC9A52C,
        'canRedeem': true,
      },
      {
        'id': '18k',
        'type': 'Gold Wallet',
        'carat': '18K',
        'balance': 0.3,
        'value': 1180.76,
        'todayChange': 7.08,
        'todayChangePercentage': 0.6,
        'gradientStart': 0xFFF3D265,
        'gradientEnd': 0xFFBE9B21,
        'canRedeem': false,
      },
      {
        'id': 'inr',
        'type': 'Value Wallet',
        'carat': 'INR',
        'balance': 12000.0,
        'value': 12000.0,
        'todayChange': 0,
        'todayChangePercentage': 0,
        'gradientStart': 0xFF1A1A2E,
        'gradientEnd': 0xFF16213E,
        'canRedeem': false,
      },
    ];
  }
  
  Future<List<Map<String, dynamic>>> getProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Mock response
    return [
      {
        'id': '1',
        'name': 'Diamond Ring',
        'weight': 2.5,
        'carat': '22K',
        'price': 12026.25,
        'caratColor': 0xFFC9A52C,
      },
      {
        'id': '2',
        'name': 'Gold Coin',
        'weight': 1.0,
        'carat': '24K',
        'price': 5247.80,
        'caratColor': 0xFFD4AF37,
      },
      {
        'id': '3',
        'name': 'Gold Chain',
        'weight': 4.0,
        'carat': '22K',
        'price': 19242.00,
        'caratColor': 0xFFC9A52C,
      },
      {
        'id': '4',
        'name': 'Earrings',
        'weight': 1.8,
        'carat': '18K',
        'price': 7084.53,
        'caratColor': 0xFFBE9B21,
      },
    ];
  }
  
  Future<List<Map<String, dynamic>>> getTransactions() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Mock response
    return [
      {
        'id': '1',
        'title': '24K Gold Purchase',
        'date': 'Today, 10:45 AM',
        'type': 'purchase',
        'weightChange': 0.125,
        'valueChange': 655.98,
        'iconColor': 0xFF4CAF50,
        'icon': 'add_circle_outline',
      },
      {
        'id': '2',
        'title': 'Gift to Rahul (22K)',
        'date': 'Yesterday, 5:30 PM',
        'type': 'gift',
        'weightChange': -0.05,
        'valueChange': 240.53,
        'iconColor': 0xFF2196F3,
        'icon': 'chat_bubble_outline',
      },
      {
        'id': '3',
        'title': '18K Gold Purchase',
        'date': 'Jan 15, 2023',
        'type': 'purchase',
        'weightChange': 0.3,
        'valueChange': 1180.76,
        'iconColor': 0xFFFFC107,
        'icon': 'account_balance_wallet_outlined',
      },
    ];
  }
  
  Future<Map<String, dynamic>> buyGold(double amount, String carat) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Mock response
    return {
      'success': true,
      'transactionId': 'txn_${DateTime.now().millisecondsSinceEpoch}',
      'message': 'Gold purchase successful',
    };
  }
  
  Future<Map<String, dynamic>> redeemGold(double weight, String carat) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Mock response
    return {
      'success': true,
      'transactionId': 'txn_${DateTime.now().millisecondsSinceEpoch}',
      'message': 'Gold redemption successful',
    };
  }
}
