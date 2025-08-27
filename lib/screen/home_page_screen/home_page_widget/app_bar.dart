import 'package:flutter/material.dart';
import '../../../shared_widget/custom_child_container.dart';
import '../home_page_model/prod_class.dart';
import 'catr_button_widget.dart';

class AppBarProfile extends StatefulWidget {
  AppBarProfile({super.key, required this.userName});

  final String userName;

  @override
  State<AppBarProfile> createState() => _AppBarProfileState();
}

class _AppBarProfileState extends State<AppBarProfile> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                ),
                const Padding(padding: EdgeInsets.only(right: 12)),
                Column(
                  children: [
                    const Text(
                      '☀️ !نهارك سعيد',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF160704),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // Text(
                    //   '${widget.userName}',
                    //   style: const TextStyle(
                    //     fontSize: 16,
                    //     color: Color(0xFF160704),
                    //   ),
                    // ),
                  ],
                ),
                const Spacer(),
                Stack(clipBehavior: Clip.none, children: [
                  CustomChildContainer(
                    width: 95,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 18, left: 30, top: 7, bottom: 5),
                      child: Column(
                        children: [
                          const Text(
                            'المنتجات',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF160704)),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(bottom: 0.4, top: 0.4)),
                          Text(
                            '$counter',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF160704),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                   Positioned(
                    left: -27,
                    child:CartButton(prodInfo: ProdInfo(prodId: 1, nameProd: 'شوكولا بيضاء', description: 'حليب', price: '1200 \$'),),

                  ),
                ]),
              ],
            ),
          ),
        ]
    );
  }
}
