import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared_widget/custom_child_container.dart';
import '../home_page_model/prod_class.dart';
import 'catr_button_widget.dart';
import 'package:chocolate_store/screen/profile/profile_page.dart';
import '../../../screen/cart_info_page/cart_cubit/cart_cubit.dart';
import '../../../screen/favorite_page/favoraite_page.dart';
import '../../../screen/cart_info_page/cart_info_page.dart';
import '../../../presentation/screens/search_screen.dart';

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
            // أيقونات البحث والسلة في الزاوية اليمينية
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // أيقونة البحث
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                // أيقونة السلة
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartInfoPage(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}
