import 'package:chocolate_store/screen/cart_info_page/cart_info_widget/counter.dart';
import 'package:chocolate_store/screen/home_page_screen/home_page_model/prod_class.dart';
import 'package:chocolate_store/shared_widget/custom_child_container.dart';
import 'package:flutter/material.dart';

class YourOrderList extends StatelessWidget {
  const YourOrderList({
    super.key,
    required this.prodInfo,
  });

  final ProdInfo prodInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 700,
      child: ListView.builder( itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            CustomChildContainer(
                child: Row(
                  children: [
                    Image.asset(
                      'asset/image/main_image.jpg',
                      width: 100,
                      height: 80,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text('${prodInfo.nameProd}'),
                        Text('${prodInfo.description}'),
                        SizedBox(
                          height: 20,
                        ),
                        Text('${prodInfo.price}'),
                      ],
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    CounterOrder(
                      productId: '123',
                    ),
                  ],
                ),
                width: 350,
                height: 115),
            SizedBox(height: 6,)
          ],
        );
      }),
    );
  }
}
