import 'package:flutter/material.dart';
import '../../../shared_widget/custom_child_container.dart';
import '../home_page_model/prod_class.dart';
import 'catr_button_widget.dart';
import 'package:chocolate_store/screen/profile/profile_page.dart';

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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 35,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: [
            // const CircleAvatar(
            //   backgroundColor: Colors.white,
            //   radius: 25,
            // ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
              icon: const Icon(Icons.person),
              iconSize: 27,
            ),
            Padding(padding: EdgeInsets.only(right: 12)),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                height: 46,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 18, left: 30, top: 6, bottom: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'المنتجات',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF160704)),
                      ),
                      const SizedBox(height: 2),
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
                child: CartButton(
                  prodInfo: ProdInfo(
                      prodId: 1,
                      nameProd: 'شوكولا بيضاء',
                      description: 'حليب',
                      price: '1200 \$'),
                ),
              ),
            ]),
          ],
        ),
      ),
    ]);
  }
}
