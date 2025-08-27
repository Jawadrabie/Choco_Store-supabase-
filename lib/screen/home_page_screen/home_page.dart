import 'package:flutter/material.dart';
import '../../shared_widget/custom_main_container.dart';
import '../../shared_widget/nav_bar/nav_bar.dart';
// Import your page widgets:
import '../all_product_screen/all_product.dart';
import '../favorite_page/favoraite_page.dart';
import '../favorite_page/favorite_widget/card_fav_widget.dart';
import 'home_page_widget/app_bar.dart';
import 'home_page_widget/best_prod_widget.dart';
import 'home_page_widget/recommend_prod_widget.dart';
import 'home_page_widget/prod_column_widget.dart';
import '../cart_info_page/cart_info_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required String userName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  // List of your main screens:
  final List<Widget> screens = [
    // Home content (as before)
    CustomMainContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            AppBarProfile(userName: 'اسم المستخدم'),
            const SizedBox(height: 45),
            BestProdWidget(),
            const SizedBox(height: 25),
            RecommendProd(),
            const SizedBox(height: 20),
            ProdColumnWidget(),
          ],
        ),
      ),
    ),
    // Other main pages
    AllProductPage(),
    CartInfoPage(),
    CardFavWidget(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFD6C0B0), // match your main background
        body: Stack(
          children: [
            // Show the currently selected main page
            screens[selectedIndex],
            // Floating NavBar
            Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: CustomBottomNavBar(
                  currentIndex: selectedIndex,
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}