import 'package:flutter/material.dart';
import '../utils/secure_storage.dart';
import '../services/api_client.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String _userEmail = '';
  String _authToken = '';
  
  bool get isLoggedIn => _isLoggedIn;
  String get userEmail => _userEmail;
  String get authToken => _authToken;
  
  AuthProvider() {
    _checkLoginStatus();
  }
  
  Future<void> _checkLoginStatus() async {
    final token = await SecureStorage.readToken();
    if (token != null) {
      _isLoggedIn = true;
      _authToken = token;
      final credentials = await SecureStorage.readCredentials();
      _userEmail = credentials['email'] ?? '';
      notifyListeners();
    }
  }
  
  Future<bool> login(String email, String password) async {
    final apiClient = ApiClient();
    final response = await apiClient.login(email, password);
    
    if (response['success']) {
      _isLoggedIn = true;
      _userEmail = response['user']['email'];
      _authToken = response['token'];
      
      // Save to secure storage
      await SecureStorage.saveToken(_authToken);
      await SecureStorage.saveCredentials(email, password);
      
      notifyListeners();
      return true;
    } else {
      _isLoggedIn = false;
      _userEmail = '';
      _authToken = '';
      notifyListeners();
      return false;
    }
  }
  
  Future<void> logout() async {
    _isLoggedIn = false;
    _userEmail = '';
    _authToken = '';
    
    // Clear secure storage
    await SecureStorage.deleteToken();
    await SecureStorage.deleteCredentials();
    
    notifyListeners();
  }
}
