import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // <-- Import for Bloc context extensions

import '../../cart_info_page/cart_cubit/cart_cubit.dart';
import '../../cart_info_page/cart_info_page.dart';
import '../home_page_model/prod_class.dart';

class CartButton extends StatelessWidget {
  final ProdInfo prodInfo;

  const CartButton({super.key, required this.prodInfo});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<CartCubit>().addToCart(prodInfo);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تمت الإضافة للسلة!'),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.green,
          ),
        );
        // إزالة التنقل التلقائي لصفحة السلة
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF160704),
        foregroundColor: const Color(0xFFB69E99),
        shape: const CircleBorder(),
      ),
      child: const Icon(Icons.shopping_cart_outlined),
    );
  }
}