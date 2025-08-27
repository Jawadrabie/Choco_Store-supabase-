import 'package:chocolate_store/screen/home_page_screen/home_page_model/prod_class.dart';
import 'package:flutter/material.dart';

import '../../../shared_widget/custom_child_container.dart';
import '../../product_info_screen/product_info_page.dart';

class BestProdWidget extends StatelessWidget {
  const BestProdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomChildContainer(
        width: 325,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ٍ'
                      'تصفح منتجنا المميز\n ✨!لهذا الأسبوع',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF160704)),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        const Text(
                          'عرض المزيد',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF160704),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return ProductInfoPage(
                                  prodInfo: ProdInfo(
                                      image: Image.asset(
                                          'asset/image/main_image.jpg'),
                                      nameProd: 'منتج جديد',
                                      description: 'شوكولا بيضاء',
                                      price: '1200',
                                      prodId: 123),
                                );
                              }),
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            size: 19,
                            color: Color(0xFF160704),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 18,
              ),
              Container(
                width: 146,
                height: 146,
                color: Colors.white,
                child: Image.asset(
                  'asset/image/main_image.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
