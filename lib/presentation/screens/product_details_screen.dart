// lib/presentation/screens/product_details_screen.dart
import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.imageUrl ?? '',
                height: 220, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 100)),
            const SizedBox(height: 16),
            Text(product.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(product.description ?? '',
                style: const TextStyle(fontSize: 14, color: Colors.black87)),
            const SizedBox(height: 16),
            Text('${product.price} \$',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border),
                    label: const Text("إضافة للمفضلة"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart_outlined),
                    label: const Text("إضافة للسلة"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
