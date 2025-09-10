import 'package:chocolate_store/screen/home_page_screen/home_page_widget/items_widget.dart';
import 'package:flutter/material.dart';
import '../home_page_model/prod_class.dart';
import 'catr_button_widget.dart';
import 'favorite_button_widget.dart';

class StackButtonWidget extends StatelessWidget {
  final ProdInfo? prodInfo;
  
  const StackButtonWidget({super.key, this.prodInfo});

  @override
  Widget build(BuildContext context) {
    // إذا لم يتم تمرير prodInfo، استخدم بيانات افتراضية
    final productInfo = prodInfo ?? ProdInfo(
      prodId: 0,
      nameProd: 'منتج افتراضي',
      description: 'وصف المنتج',
      price: '0 \$',
    );

    return Container(
      width: 160,
      height: 190,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ItemWidget(prodInfo: productInfo),
          // زر المفضلة (أعلى اليسار)
          Positioned(
            top: 8,
           left: 0,
            child: FavoriteButton(productId: productInfo.prodId, size: 18),
          ),
          // زر السلة (أسفل اليمين)
          Positioned(
            bottom: 4,
            right: 14,
            child: CartButton(prodInfo: productInfo),
          ),
        ],
      ),
    );
  }
}
