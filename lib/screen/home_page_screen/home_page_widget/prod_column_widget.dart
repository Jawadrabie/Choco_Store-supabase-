import 'package:chocolate_store/screen/home_page_screen/home_page_widget/stack_button_widget.dart';
import 'package:chocolate_store/screen/home_page_screen/home_page_model/prod_class.dart';
import 'package:flutter/material.dart';

class ProdColumnWidget extends StatelessWidget {
  final List<ProdInfo> products;
  
  const ProdColumnWidget({super.key, required this.products});
  
  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return SizedBox.shrink();
    }
    
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: StackButtonWidget(prodInfo: products[0])),
            SizedBox(width: 12),
            Expanded(child: products.length > 1 ? StackButtonWidget(prodInfo: products[1]) : SizedBox.shrink()),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: products.length > 2 ? StackButtonWidget(prodInfo: products[2]) : SizedBox.shrink()),
            SizedBox(width: 12),
            Expanded(child: products.length > 3 ? StackButtonWidget(prodInfo: products[3]) : SizedBox.shrink()),
          ],
        ),
      ],
    );
  }
}
