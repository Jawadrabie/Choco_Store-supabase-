import 'package:chocolate_store/screen/home_page_screen/home_page_model/prod_class.dart';
import 'package:chocolate_store/screen/home_page_screen/home_page_widget/catr_button_widget.dart';
import 'package:chocolate_store/shared_widget/custom_child_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomChildContainer(
      width: 200, height: 60,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('أضف إلى سلة التسوق',style: TextStyle(
                color: CupertinoColors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none
            ),),
          ),
          SizedBox(width: 20.5,),
          CartButton(prodInfo: ProdInfo(prodId: 1, nameProd: 'شوكولا بيضاء', description: 'حليب', price: '1200 \$'),),
        ],
      ),
    );
  }
}
