import 'package:flutter/material.dart';
import '../../presentation/screens/delevery_screen.dart';
import '../../presentation/screens/order_screen.dart';
import '../../shared_widget/custom_main_container.dart';
import '../../shared_widget/nav_bar/nav_bar.dart';
// Import your page widgets:

import '../favorite_page/favorite_widget/card_fav_widget.dart';
import 'home_page_widget/app_bar.dart';
import 'home_page_widget/best_prod_widget.dart';
import 'home_page_widget/recommend_prod_widget.dart';
import '../../repositories/product_repository.dart';
import '../home_page_screen/home_page_widget/stack_button_widget.dart';
import '../home_page_screen/home_page_model/prod_class.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/category/category_cubit.dart';
import '../../cubits/category/category_state.dart';
import '../../presentation/screens/category_products_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  // متغير ليتأكد إنو الاقتباس ينعرض مرة وحدة
  bool _quoteShown = false;

  @override
  void initState() {
    super.initState();
    // منعرض الاقتباس أول مرة يفتح التطبيق
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_quoteShown) {
        _showRandomQuote(context);
        _quoteShown = true;
      }
    });
  }

  void _showRandomQuote(BuildContext context) {
    final quotes = [
      "✨🍫 الحياة مثل الشوكولا، كل قطعة تجربة مختلفة.",
      "✨🍫 السعادة تشبه قطعة شوكولا تذوب ببطء.",
      "✨🍫 الشوكولا دواء سحري للحزن.",
      "✨🍫 قطعة شوكولا كافية لتغيير يومك.",
      "✨🍫 أول لوح شوكولا صُنع في عام 1847 في بريطانيا.",

          "حبوب الكاكاو كانت تُستخدم كعملة عند شعوب المايا والأزتك.✨🍫",

          "✨🍫الشوكولا الداكنة غنية بمضادات الأكسدة وتُحسن المزاج.",

          "سويسرا هي الدولة الأكثر استهلاكًا للشوكولا في العالم. ✨🍫",

          "اسم الكاكاو مشتق من كلمة بلغة المايا تعني طعام الآلهة. ✨🍫",
    ];

    final randomQuote = (quotes..shuffle()).first;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "🌟 اقتباس اليوم 🌟",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: Text(
          randomQuote,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "متابعة",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryScroller() {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state.isLoading && state.categories.isEmpty) {
          return const SizedBox(
            height: 110,
            child: Center(
                child: CircularProgressIndicator(
              color: Color(0xFFBD9872)
            )),
          );
        }
        if (state.error != null && state.categories.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(' خطأ في الأقسام: ${state.error}'),
          );
        }
        final categories = state.categories;
        if (categories.isEmpty) {
          return const SizedBox(height: 8);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final cat = categories[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CategoryProductsScreen(category: cat),
                      ),
                    );
                  },
                  child: Container(
                    width: 110,
                    decoration: BoxDecoration(
                      color:  Color(0xFFBD9882),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: (cat.imageUrl != null &&
                                    cat.imageUrl!.isNotEmpty)
                                ? Image.network(
                                    cat.imageUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.image, size: 40),
                                  )
                                : Image.asset('asset/image/main_image.jpg',
                                    fit: BoxFit.cover),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            cat.name,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      CustomMainContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: RefreshIndicator(
            onRefresh: () async {
              try {
                await context.read<CategoryCubit>().refresh();
              } catch (_) {}
              setState(() {});
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppBarProfile(userName: 'اسم المستخدم'),
                  SizedBox(height: 20),
                  _buildCategoryScroller(),
                  SizedBox(height: 15),
                  BestProdWidget(),
                  RecommendProd(),
                  Builder(
                    builder: (context) {
                      final repo = context.read<ProductRepository>();
                      return FutureBuilder(
                        future: repo.getFeaturedProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color:   Color(0xFFBD9872)
                            ));
                          }
                          if (snapshot.hasError) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(' خطأ: ${snapshot.error}'),
                            );
                          }
                          final products = snapshot.data ?? const [];
                          if (products.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              // childAspectRatio: 0.85,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final p = products[index];
                              final hasUrl =
                                  p.imageUrl != null && p.imageUrl!.isNotEmpty;
                              final prodInfo = ProdInfo(
                                prodId: p.id.hashCode,
                                image: hasUrl
                                    ? Image.network(
                                        p.imageUrl!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            Image.asset(
                                                'asset/image/main_image.jpg',
                                                fit: BoxFit.cover),
                                      )
                                    : Image.asset('asset/image/main_image.jpg',
                                        fit: BoxFit.cover),
                                nameProd: p.name,
                                description:'${p.description} \$',
                                price: '${p.price} \$',
                              );
                              return StackButtonWidget(prodInfo: prodInfo);
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      DeliveryInfoScreen(),
      CustomChocolateOrderPage(),
<<<<<<< HEAD
=======

      //AllProductPage(),
     // CartInfoPage(),

>>>>>>> 7a26b207434847a11ff955558720d47470c76cbf
      CardFavWidget(),
    ];

    //navbar
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFD6C0B0),
        body: Stack(
          children: [
            screens[selectedIndex],
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
