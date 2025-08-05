import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionItem(
                context,
                icon: Icons.add,
                color: Colors.amber[100]!,
                iconColor: const Color(0xFFD4AF37),
                label: 'Buy Gold',
                onTap: () {
                  // Handle buy gold action
                },
              ),
              _buildActionItem(
                context,
                icon: Icons.shopping_cart,
                color: Colors.blue[100]!,
                iconColor: Colors.blue,
                label: 'Sell Gold',
                onTap: () {
                  // Handle sell gold action
                },
              ),
              _buildActionItem(
                context,
                icon: Icons.card_giftcard,
                color: Colors.green[100]!,
                iconColor: Colors.green,
                label: 'Gift Gold',
                onTap: () {
                  // Handle gift gold action
                },
              ),
              _buildActionItem(
                context,
                icon: Icons.history,
                color: Colors.purple[100]!,
                iconColor: Colors.purple,
                label: 'History',
                onTap: () {
                  // Handle history action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(icon, color: iconColor),
            onPressed: onTap,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
