import 'package:flutter/material.dart';
import '../providers/wallet_provider.dart';

class WalletCards extends StatefulWidget {
  final List<WalletItem> wallets;
  
  const WalletCards({Key? key, required this.wallets}) : super(key: key);

  @override
  _WalletCardsState createState() => _WalletCardsState();
}

class _WalletCardsState extends State<WalletCards> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.wallets.length,
            itemBuilder: (context, index) {
              final wallet = widget.wallets[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [wallet.gradientStart, wallet.gradientEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            wallet.type,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            wallet.id == 'inr' 
                                ? '₹${wallet.balance.toStringAsFixed(2)}' 
                                : '${wallet.balance.toStringAsFixed(2)} g',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            wallet.id == 'inr' 
                                ? 'Available Balance' 
                                : '≈ ₹${wallet.value.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                wallet.id == 'inr' ? 'Last Transaction' : 'Today\'s Change',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  if (wallet.todayChange > 0)
                                    const Icon(
                                      Icons.arrow_drop_up,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  Text(
                                    wallet.id == 'inr' 
                                        ? '+₹${wallet.value.toStringAsFixed(2)}' 
                                        : '+₹${wallet.todayChange.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: Text(
                              wallet.carat,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (wallet.id != 'inr')
                            ElevatedButton(
                              onPressed: () {
                                // Handle redeem action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFFD4AF37),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              ),
                              child: Text(
                                wallet.canRedeem ? 'Redeem' : 'Buy More',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          if (wallet.id == 'inr')
                            ElevatedButton(
                              onPressed: () {
                                // Handle withdraw action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              ),
                              child: const Text(
                                'Withdraw',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        // Indicator dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.wallets.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index 
                    ? const Color(0xFFD4AF37) 
                    : Colors.grey.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
