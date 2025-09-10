import 'package:chocolate_store/shared_widget/custom_main_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/product/product_cubit.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../screen/home_page_screen/home_page_model/prod_class.dart';
import '../../screen/home_page_screen/home_page_widget/catr_button_widget.dart';
import '../../screen/home_page_screen/home_page_widget/items_widget.dart';
import '../../screen/home_page_screen/home_page_widget/stack_button_widget.dart';

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
    _future =
        context.read<ProductCubit>().getProductsByCategory(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return CustomMainContainer(
      child: Scaffold(
        backgroundColor: const Color(0xFFD6C0B0),
        appBar: AppBar(
          title: Text(
            widget.category.name,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF995D39),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _future = context
                  .read<ProductCubit>()
                  .getProductsByCategory(widget.category.id);
            });
            await _future;
          },
          child: CustomMainContainer(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<List<Product>>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: Color(0xFFBD9872)));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('خطأ: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('لا يوجد منتجات في هذا القسم'));
                  }

                  final products = snapshot.data!;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // childAspectRatio: 0.85,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final p = products[index];
                      final hasUrl =
                          p.imageUrl != null && p.imageUrl!.isNotEmpty;
                      final prodInfo = ProdInfo(
                        prodId: p.id.hashCode,
                        image: hasUrl
                            ? Image.network(
                                p.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Image.asset(
                                    'asset/image/main_image.jpg',
                                    fit: BoxFit.cover),
                              )
                            : Image.asset('asset/image/main_image.jpg',
                                fit: BoxFit.cover),
                        nameProd: p.name,
                        description: p.description ?? '',
                        price: '${p.price} \$',
                      );

                      return StackButtonWidget(prodInfo: prodInfo);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
