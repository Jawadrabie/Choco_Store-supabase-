import 'package:chocolate_store/screen/all_product_screen/all_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecommendProd extends StatelessWidget {
  const RecommendProd({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [ TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return  AllProductPage();
              }),
            );
          },
          child: Text(
            'عرض الجميع',
            style: TextStyle(decoration: TextDecoration.underline, color: Colors.white, fontSize: 15, decorationColor: Colors.white),
          ),
        ),
          SizedBox(width: 118.8,),
         Text('هل تريد أصنافاً أكثر؟',style: TextStyle( color: Colors.white, fontSize: 15),
          ),


        ],
      ),
    );
  }
}
