import 'package:chocolate_store/screen/home_page_screen/home_page_model/prod_class.dart';
import 'package:chocolate_store/screen/product_info_screen/add_to_cart_button.dart';
import 'package:chocolate_store/shared_widget/custom_child_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/favorites/favorites_cubit.dart';
import '../cart_info_page/cart_cubit/cart_cubit.dart';
import '../home_page_screen/home_page_widget/catr_button_widget.dart';

import '../../shared_widget/custom_main_container.dart';

class ProductInfoPage extends StatelessWidget {
  final ProdInfo prodInfo;

  const ProductInfoPage({super.key, required this.prodInfo});

  @override
  Widget build(BuildContext context) {
    return CustomMainContainer(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          BackButton(color: Color(0xFF000000),),
          Center(
            child: CustomChildContainer(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: prodInfo.image != null
                      ? FittedBox(
                          fit: BoxFit.cover,
                          child: prodInfo.image,
                        )
                      : Image.asset(
                          'asset/image/main_image.jpg',
                          fit: BoxFit.cover,
                        ),
                ),
                width: 350,
                height: 400),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              '${prodInfo.nameProd}',
              style: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 18,
                  decoration: TextDecoration.none),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${prodInfo.description}',
            style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w300,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '${prodInfo.price} \$',
            style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w300,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 2,
            color: Colors.white60,
            indent: 12,
            endIndent: 12,
          ),
          Text(
            '${prodInfo.description} ',
            style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w300,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 80,
          ),
          // أزرار الإجراءات
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // زر المفضلة
              BlocBuilder<FavoritesCubit, Set<int>>(
                builder: (context, favoriteIds) {
                  final isFavorite = favoriteIds.contains(prodInfo.prodId);
                  return ElevatedButton.icon(
                    onPressed: () {
                      context.read<FavoritesCubit>().toggleFavorite(prodInfo.prodId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isFavorite ? 'تم إزالة المنتج من المفضلة' : 'تم إضافة المنتج للمفضلة',
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                    ),
                    label: Text(
                      isFavorite ? 'في المفضلة' : 'إضافة للمفضلة',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFavorite ? Colors.red.withOpacity(0.8) : Colors.brown[700],
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  );
                },
              ),
              // زر السلة
              BlocBuilder<CartCubit, Map<ProdInfo, int>>(
                builder: (context, cartMap) {
                  final isInCart = cartMap.containsKey(prodInfo);
                  return ElevatedButton.icon(
                    onPressed: () {
                      if (isInCart) {
                        context.read<CartCubit>().removeFromCart(prodInfo);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('تم إزالة المنتج من السلة'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.orange,
                          ),
                        );
                      } else {
                        context.read<CartCubit>().addToCart(prodInfo);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('تم إضافة المنتج للسلة'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined, 
                      color: Colors.white
                    ),
                    label: Text(
                      isInCart ? 'في السلة' : 'إضافة للسلة',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isInCart ? Colors.green[700] : Colors.brown[700],
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
