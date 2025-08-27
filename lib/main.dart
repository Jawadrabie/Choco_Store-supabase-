import 'package:chocolate_store/screen/all_product_screen/all_product_widget/custom_text_field/cubit/text_field_cubit.dart';
import 'package:chocolate_store/screen/cart_info_page/cart_counter_bloc/cart_counter_bloc.dart';
import 'package:chocolate_store/screen/cart_info_page/cart_cubit/cart_cubit.dart';
import 'package:chocolate_store/screen/home_page_screen/home_page.dart';
import 'package:chocolate_store/screen/home_page_screen/home_page_model/prod_class.dart';
import 'package:chocolate_store/screen/sign_in_up_screen/sign_in_up_page.dart';
import 'package:chocolate_store/screen/splash_screen/first_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {

  runApp(const ChocolateStore());
}

class ChocolateStore extends StatelessWidget {
  const ChocolateStore({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (BuildContext context) =>CartCounterBloc()),
        BlocProvider(create: (BuildContext context) => GetSearchProdCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
         home:SplashScreen(),

      ),

    );
  }
}
