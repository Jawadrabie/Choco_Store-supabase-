import 'package:chocolate_store/screen/home_page_screen/home_page_model/prod_class.dart';
import 'package:chocolate_store/shared_widget/custom_main_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_cubit/cart_cubit.dart';
import 'cart_info_widget/your_order_list.dart';

class CartInfoPage extends StatelessWidget {
  const CartInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: CustomMainContainer(
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 25),
                Row(
                  children: [
                    BackButton(color: Color(0xFF000000)),
                    SizedBox(width: 75),
                    Text(
                      'سلة تسوقك',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: BlocBuilder<CartCubit, Map<ProdInfo, int>>(
                    builder: (context, cartMap) {
                      if (cartMap.isEmpty) {
                        return Center(
                          child: Text(
                            'السلة فارغة',
                            style: TextStyle(color: Colors.brown, fontSize: 20),
                          ),
                        );
                      }
                      final entries = cartMap.entries.toList();
                      return ListView.builder(
                        itemCount: entries.length,
                        itemBuilder: (context, index) {
                          final prod = entries[index].key;
                          final quantity = entries[index].value;
                          return Card(
                            color: Colors.brown[200],
                            child: ListTile(
                              leading: Image.asset(
                                'asset/image/main_image_.jpg',
                                width: 50,
                                height: 50,
                              ),
                              title: Text(prod.nameProd, style: TextStyle(fontSize: 18)),
                              subtitle: Text(
                                '${prod.price} \$\nالكمية: $quantity',
                                style: TextStyle(fontSize: 16),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove_circle_outline),
                                    onPressed: () {
                                      context.read<CartCubit>().decreaseQuantity(prod);
                                    },
                                  ),
                                  Text('$quantity', style: TextStyle(fontSize: 18)),
                                  IconButton(
                                    icon: Icon(Icons.add_circle_outline),
                                    onPressed: () {
                                      context.read<CartCubit>().increaseQuantity(prod);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      context.read<CartCubit>().removeFromCart(prod);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}