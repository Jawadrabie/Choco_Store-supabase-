import 'package:chocolate_store/presentation/screens/featured_products_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecommendProd extends StatelessWidget {
  const RecommendProd({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        children: [
          const Text(
            'الأكثر مبيعًا',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.white,
              fontSize: 15,
              decorationColor: Colors.white,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const FeaturedProductsScreen(),
                ),
              );
            },
            child: const Text(
              'عرض الكل',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
