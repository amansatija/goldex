import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();
  
  // Keys
  static const _tokenKey = 'auth_token';
  static const _emailKey = 'user_email';
  static const _passwordKey = 'user_password';
  
  // Default credentials
  static const defaultEmail = 'admin@goldex.com';
  static const defaultPassword = 'goldEX@123';
  
  // Write token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }
  
  // Read token
  static Future<String?> readToken() async {
    return await _storage.read(key: _tokenKey);
  }
  
  // Delete token
  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
  
  // Save user credentials
  static Future<void> saveCredentials(String email, String password) async {
    await _storage.write(key: _emailKey, value: email);
    await _storage.write(key: _passwordKey, value: password);
  }
  
  // Read user credentials
  static Future<Map<String, String?>> readCredentials() async {
    final email = await _storage.read(key: _emailKey);
    final password = await _storage.read(key: _passwordKey);
    return {
      'email': email,
      'password': password,
    };
  }
  
  // Delete user credentials
  static Future<void> deleteCredentials() async {
    await _storage.delete(key: _emailKey);
    await _storage.delete(key: _passwordKey);
  }
}
