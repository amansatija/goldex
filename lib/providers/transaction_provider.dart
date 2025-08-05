import 'package:flutter/material.dart';
import '../services/api_client.dart';

class Transaction {
  final String id;
  final String title;
  final String date;
  final String type;
  final double weightChange;
  final double valueChange;
  final Color iconColor;
  final IconData icon;

  Transaction({
    required this.id,
    required this.title,
    required this.date,
    required this.type,
    required this.weightChange,
    required this.valueChange,
    required this.iconColor,
    required this.icon,
  });

  // Factory constructor to create Transaction from JSON
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      type: json['type'],
      weightChange: json['weightChange'],
      valueChange: json['valueChange'],
      iconColor: Color(json['iconColor']),
      icon: _getIconDataFromString(json['icon']),
    );
  }

  // Helper method to convert string to IconData
  static IconData _getIconDataFromString(String iconString) {
    switch (iconString) {
      case 'add_circle_outline':
        return Icons.add_circle_outline;
      case 'chat_bubble_outline':
        return Icons.chat_bubble_outline;
      case 'account_balance_wallet_outlined':
        return Icons.account_balance_wallet_outlined;
      default:
        return Icons.account_balance;
    }
  }
}

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];
  bool _isLoading = false;
  String _error = '';

  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchTransactions() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final apiClient = ApiClient();
      final transactionData = await apiClient.getTransactions();
      _transactions = transactionData.map((data) => Transaction.fromJson(data)).toList();
    } catch (e) {
      _error = 'Failed to fetch transactions';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
