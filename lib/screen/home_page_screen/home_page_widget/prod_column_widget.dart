import 'package:chocolate_store/screen/home_page_screen/home_page_widget/stack_button_widget.dart';
import 'package:flutter/material.dart';

class ProdColumnWidget extends StatelessWidget {
  const ProdColumnWidget({super.key});
  @override
  Widget build(BuildContext context) {
        return Column(
          children: [
            Row(children: [StackButtonWidget(), SizedBox(width: 12,) ,StackButtonWidget(),],),
            SizedBox(height: 10,),
            Row(children: [StackButtonWidget(), SizedBox(width: 12,) ,StackButtonWidget(),],),
          ],
        );

  }
}
