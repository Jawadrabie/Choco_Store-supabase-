import 'package:chocolate_store/shared_widget/custom_main_container.dart';
import 'package:flutter/material.dart';


class FavoritPage extends StatelessWidget {
  const FavoritPage({super.key});

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
                      'المفضلة',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Text('d'),
                ),
            ]),
          ),
        ),
      ),
    );
  }
}