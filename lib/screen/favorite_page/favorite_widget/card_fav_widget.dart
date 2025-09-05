import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/favorites/favorites_cubit.dart';
import '../../../repositories/product_repository.dart';
import '../../home_page_screen/home_page_widget/items_widget.dart';
import '../../home_page_screen/home_page_widget/catr_button_widget.dart';
import '../../home_page_screen/home_page_widget/stack_button_widget.dart';
import '../../home_page_screen/home_page_model/prod_class.dart';

class CardFavWidget extends StatelessWidget {
  const CardFavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFD6C0B0),
        appBar: AppBar(
          backgroundColor: const Color(0xFFD6C0B0),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'المفضلة',
            style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<FavoritesCubit, Set<int>>(
          builder: (context, favoriteIds) {
            if (favoriteIds.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'لا توجد منتجات في المفضلة',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }

            return FutureBuilder(
              future: context.read<ProductRepository>().getAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('خطأ في تحميل المنتجات: ${snapshot.error}'),
                  );
                }

                final allProducts = snapshot.data ?? [];
                final favoriteProducts = allProducts
                    .where((product) => favoriteIds.contains(product.id.hashCode))
                    .toList();

                if (favoriteProducts.isEmpty) {
                  return Center(
                    child: Text(
                      'لم تعد المنتجات المفضلة متاحة',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: favoriteProducts.length,
                  itemBuilder: (context, index) {
                    final product = favoriteProducts[index];
                    final hasUrl = product.imageUrl != null && product.imageUrl!.isNotEmpty;
                    final prodInfo = ProdInfo(
                      prodId: product.id.hashCode,
                      image: hasUrl
                          ? Image.network(
                              product.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Image.asset('asset/image/main_image.jpg', fit: BoxFit.cover),
                            )
                          : Image.asset('asset/image/main_image.jpg', fit: BoxFit.cover),
                      nameProd: product.name,
                      description: product.description ?? '',
                      price: '${product.price} \$',
                    );
                    return StackButtonWidget(prodInfo: prodInfo);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
