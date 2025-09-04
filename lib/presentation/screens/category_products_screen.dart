import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/product/product_cubit.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../screen/home_page_screen/home_page_model/prod_class.dart';
import '../../screen/home_page_screen/home_page_widget/catr_button_widget.dart';
import '../../screen/home_page_screen/home_page_widget/items_widget.dart';

class CategoryProductsScreen extends StatefulWidget {
  final Category category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  late Future<List<Product>> _future;

  @override
  void initState() {
    super.initState();
    _future = context.read<ProductCubit>().getProductsByCategory(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6C0B0),
      appBar: AppBar(title: Text(widget.category.name)),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _future = context.read<ProductCubit>().getProductsByCategory(widget.category.id);
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
            } else if (snapshot.hasError) {
              return Center(child: Text('خطأ: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('لا يوجد منتجات في هذا القسم'));
            }

            final products = snapshot.data!;
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
      ),
    );
  }
}
