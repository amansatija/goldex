import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/wallet_provider.dart';
import 'providers/product_provider.dart';
import 'providers/transaction_provider.dart';
import 'theme/light_theme.dart';
import 'theme/dark_theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final ValueNotifier<ThemeData> _themeNotifier = ValueNotifier(LightTheme.theme);

  // Toggle between light and dark themes
  void toggleTheme() {
    _themeNotifier.value = _themeNotifier.value == LightTheme.theme
        ? DarkTheme.theme
        : LightTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: _themeNotifier,
      builder: (context, theme, child) {
        return MaterialApp(
          title: 'GoldCarat - Digital Gold Investment Platform',
          theme: theme,
          home: const HomeScreen(),
        );
      },
    );
  }
}
