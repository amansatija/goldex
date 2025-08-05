import 'package:flutter/material.dart';
import '../services/api_client.dart';

class WalletItem {
  final String id;
  final String type;
  final String carat;
  final double balance;
  final double value;
  final double todayChange;
  final double todayChangePercentage;
  final Color gradientStart;
  final Color gradientEnd;
  final bool canRedeem;

  WalletItem({
    required this.id,
    required this.type,
    required this.carat,
    required this.balance,
    required this.value,
    required this.todayChange,
    required this.todayChangePercentage,
    required this.gradientStart,
    required this.gradientEnd,
    required this.canRedeem,
  });

  // Factory constructor to create WalletItem from JSON
  factory WalletItem.fromJson(Map<String, dynamic> json) {
    return WalletItem(
      id: json['id'],
      type: json['type'],
      carat: json['carat'],
      balance: json['balance'],
      value: json['value'],
      todayChange: json['todayChange'],
      todayChangePercentage: json['todayChangePercentage'],
      gradientStart: Color(json['gradientStart']),
      gradientEnd: Color(json['gradientEnd']),
      canRedeem: json['canRedeem'],
    );
  }
}

class WalletProvider with ChangeNotifier {
  List<WalletItem> _wallets = [];
  bool _isLoading = false;
  String _error = '';

  List<WalletItem> get wallets => _wallets;
  bool get isLoading => _isLoading;
  String get error => _error;

  WalletItem getWalletById(String id) {
    return _wallets.firstWhere((wallet) => wallet.id == id);
  }

  Future<void> fetchWallets() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final apiClient = ApiClient();
      final walletData = await apiClient.getWalletData();
      _wallets = walletData.map((data) => WalletItem.fromJson(data)).toList();
    } catch (e) {
      _error = 'Failed to fetch wallet data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> buyGold(double amount, String carat) async {
    try {
      final apiClient = ApiClient();
      final result = await apiClient.buyGold(amount, carat);
      
      if (result['success']) {
        // Update wallet data after successful purchase
        await fetchWallets();
        notifyListeners();
      }
    } catch (e) {
      _error = 'Failed to buy gold';
      notifyListeners();
    }
  }

  Future<void> redeemGold(double weight, String carat) async {
    try {
      final apiClient = ApiClient();
      final result = await apiClient.redeemGold(weight, carat);
      
      if (result['success']) {
        // Update wallet data after successful redemption
        await fetchWallets();
        notifyListeners();
      }
    } catch (e) {
      _error = 'Failed to redeem gold';
      notifyListeners();
    }
  }
}
