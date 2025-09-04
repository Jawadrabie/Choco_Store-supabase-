import 'package:chocolate_store/screen/home_page_screen/home_page_model/prod_class.dart';
import 'package:chocolate_store/screen/product_info_screen/add_to_cart_button.dart';
import 'package:chocolate_store/shared_widget/custom_child_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          Center(child: AddToCartButton()),
        ],
      ),
    ));
  }
}
