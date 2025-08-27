import 'package:chocolate_store/screen/home_page_screen/home_page_model/prod_class.dart';
import 'package:chocolate_store/screen/product_info_screen/product_info_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../shared_widget/custom_child_container.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.prodInfo});
  final ProdInfo prodInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductInfoPage(prodInfo: prodInfo),
            ),
          );
        },
        child: CustomChildContainer(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(80)),
          width: 180,
          height: 170,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'asset/image/main_image.jpg',
                    width: 100,
                    height: 100,
                  ),
                ),
                Center(
                  child: Text(
                    '${prodInfo.nameProd}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Text(
                  '${prodInfo.description}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '${prodInfo.price}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}