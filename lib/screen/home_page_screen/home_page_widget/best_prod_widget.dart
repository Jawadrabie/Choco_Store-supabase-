import 'package:flutter/material.dart';

import '../../../shared_widget/custom_child_container.dart';
import '../../../presentation/screens/trending_products_screen.dart';

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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: const Text(

                        'تصفح منتجاتنا المميزة \n\n ✨ !لهذا الأسبوع',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF160704)),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 26,top: 12),
                      child: Row(
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
                                  builder: (BuildContext context) =>  TrendingProductsScreen(),
                                )
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
