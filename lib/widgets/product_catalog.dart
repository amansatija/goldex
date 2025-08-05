import 'package:flutter/material.dart';
import '../providers/product_provider.dart';

class ProductCatalog extends StatefulWidget {
  final List<Product> products;
  
  const ProductCatalog({Key? key, required this.products}) : super(key: key);

  @override
  _ProductCatalogState createState() => _ProductCatalogState();
}

class _ProductCatalogState extends State<ProductCatalog> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Jewellery',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFD4AF37),
          labelColor: const Color(0xFFD4AF37),
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Rings'),
            Tab(text: 'Earrings'),
          ],
        ),
        SizedBox(
          height: 200,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildProductGrid(widget.products),
              _buildProductGrid(widget.products.where((product) => product.name.contains('Ring')).toList()),
              _buildProductGrid(widget.products.where((product) => product.name.contains('Earrings')).toList()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductGrid(List<Product> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: product.caratColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.diamond,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${product.weight} g | ${product.carat}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD4AF37),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
