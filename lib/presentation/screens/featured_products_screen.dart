import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product_model.dart';
import '../../repositories/product_repository.dart';
import '../../screen/home_page_screen/home_page_model/prod_class.dart';
import '../../screen/home_page_screen/home_page_widget/items_widget.dart';
import '../../screen/home_page_screen/home_page_widget/catr_button_widget.dart';

class FeaturedProductsScreen extends StatefulWidget {
  const FeaturedProductsScreen({super.key});

  @override
  State<FeaturedProductsScreen> createState() => _FeaturedProductsScreenState();
}

class _FeaturedProductsScreenState extends State<FeaturedProductsScreen> {
  late Future<List<Product>> _future;

  @override
  void initState() {
    super.initState();
    final repo = context.read<ProductRepository>();
    _future = repo.getFeaturedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6C0B0),
      appBar: AppBar(title: const Text('الأكثر مبيعًا')),
      body: RefreshIndicator(
        onRefresh: () async {
          final repo = context.read<ProductRepository>();
          setState(() {
            _future = repo.getFeaturedProducts();
          });
          await _future;
        },
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Product>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('خطأ: ${snapshot.error}'));
            }
            final products = snapshot.data ?? const <Product>[];
            if (products.isEmpty) {
              return const Center(child: Text('لا يوجد منتجات مميزة حاليًا'));
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];
                final hasUrl = p.imageUrl != null && p.imageUrl!.isNotEmpty;
                final prodInfo = ProdInfo(
                  prodId: p.id.hashCode,
                  image: hasUrl
                      ? Image.network(
                          p.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Image.asset('asset/image/main_image.jpg', fit: BoxFit.cover),
                        )
                      : Image.asset('asset/image/main_image.jpg', fit: BoxFit.cover),
                  nameProd: p.name,
                  description: p.description ?? '',
                  price: '${p.price} \$',
                );

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ItemWidget(prodInfo: prodInfo),
                    Positioned(
                      bottom: 16,
                      right: -8,
                      child: CartButton(prodInfo: prodInfo),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    ));
  }
}


