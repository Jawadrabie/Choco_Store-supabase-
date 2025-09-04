import 'package:chocolate_store/screen/home_page_screen/home_page_widget/items_widget.dart';
import 'package:flutter/material.dart';
import '../home_page_model/prod_class.dart';
import 'catr_button_widget.dart';

class StackButtonWidget extends StatelessWidget {
  StackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 190,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ItemWidget(
            prodInfo: ProdInfo(
                image: null,
                nameProd: 'منتج جديد',
                description: 'شوكولا بيضاء',
                price: '1200',
                prodId: 123),
          ),
          Positioned(
            bottom: 16,
            right: -8,
            child: CartButton(
              prodInfo: ProdInfo(
                  prodId: 1,
                  nameProd: 'شوكولا بيضاء',
                  description: 'حليب',
                  price: '1200 \$'),
            ),
          ),
        ],
      ),
    );
  }
}
