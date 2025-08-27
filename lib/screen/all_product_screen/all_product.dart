import 'package:chocolate_store/screen/all_product_screen/all_product_widget/custom_scroll_prod.dart';
import 'package:chocolate_store/shared_widget/custom_main_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllProductPage extends StatelessWidget {
  const AllProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          body: CustomMainContainer(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child:CustomScrollProd(),
            ),
          ),
        ));
  }
}
