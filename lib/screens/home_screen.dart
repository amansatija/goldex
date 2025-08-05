import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/wallet_provider.dart';
import '../providers/product_provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/wallet_cards.dart';
import '../widgets/quick_actions.dart';
import '../widgets/offer_banners.dart';
import '../widgets/product_catalog.dart';
import '../widgets/transaction_history.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? themeToggle;
  
  const HomeScreen({Key? key, this.themeToggle}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  Future<void> _fetchData() async {
    // Fetch data from all providers
    await Provider.of<WalletProvider>(context, listen: false).fetchWallets();
    await Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    await Provider.of<TransactionProvider>(context, listen: false).fetchTransactions();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final walletProvider = Provider.of<WalletProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final transactionProvider = Provider.of<TransactionProvider>(context);

    // Check if user is authenticated
    if (!authProvider.isLoggedIn) {
      return const LoginScreen();
    }

    // Show loading indicator while fetching data
    if (walletProvider.isLoading || productProvider.isLoading || transactionProvider.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Show error message if there was an error
    if (walletProvider.error.isNotEmpty || productProvider.error.isNotEmpty || transactionProvider.error.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: Text(walletProvider.error.isNotEmpty ? walletProvider.error : productProvider.error.isNotEmpty ? productProvider.error : transactionProvider.error),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFFF6E27A), const Color(0xFFD4AF37)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  'GC',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'GoldCarat',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification button press
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Handle profile button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live Gold Price Ticker
            Container(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey[100]
                  : Colors.grey[800],
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 16),
                    Text(
                      '24K: ₹5,247.80/g',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_drop_up, color: Colors.green, size: 16),
                    Text(
                      '↑0.8%',
                      style: TextStyle(fontSize: 12, color: Colors.green),
                    ),
                    SizedBox(width: 16),
                    Text(
                      '22K: ₹4,810.50/g',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_drop_up, color: Colors.green, size: 16),
                    Text(
                      '↑0.7%',
                      style: TextStyle(fontSize: 12, color: Colors.green),
                    ),
                    SizedBox(width: 16),
                    Text(
                      '18K: ₹3,935.85/g',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_drop_up, color: Colors.green, size: 16),
                    Text(
                      '↑0.6%',
                      style: TextStyle(fontSize: 12, color: Colors.green),
                    ),
                    SizedBox(width: 16),
                    Text(
                      '24K: ₹5,247.80/g',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_drop_up, color: Colors.green, size: 16),
                    Text(
                      '↑0.8%',
                      style: TextStyle(fontSize: 12, color: Colors.green),
                    ),
                    SizedBox(width: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Wallet Cards
            WalletCards(wallets: walletProvider.wallets),
            
            const SizedBox(height: 16),
            
            // Quick Actions
            QuickActions(),
            
            const SizedBox(height: 16),
            
            // Special Offer Banners
            OfferBanners(),
            
            const SizedBox(height: 16),
            
            // Product Catalog
            ProductCatalog(products: productProvider.products),
            
            const SizedBox(height: 16),
            
            // Transaction History
            TransactionHistory(transactions: transactionProvider.transactions),
            
            const SizedBox(height: 80), // Extra space for bottom navigation
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFD4AF37),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
