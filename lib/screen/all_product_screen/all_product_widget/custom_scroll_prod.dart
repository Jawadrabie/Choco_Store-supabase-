import 'package:chocolate_store/screen/all_product_screen/all_product_widget/custom_text_field/cubit/text_field_cubit.dart';
import 'package:chocolate_store/screen/all_product_screen/all_product_widget/custom_text_field/cubit/text_field_state.dart';
import 'package:chocolate_store/screen/home_page_screen/home_page_widget/stack_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home_page_screen/home_page_widget/app_bar.dart';
import '../../sign_in_up_screen/sign_in_up_page.dart';
import 'custom_text_field/custom_text_field.dart';

class CustomScrollProd extends StatelessWidget {
  const CustomScrollProd({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: AppBarProfile(userName: 'sssd')),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
        const SliverToBoxAdapter(
          child: CustomTextField(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
              childCount: 10, (context, index) => StackButtonWidget()),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.9,
          ),
        ),
        SliverToBoxAdapter(child: BlocBuilder<GetSearchProdCubit,GetSearchProdState>(builder: (context, state){
          if(state is InitialState)
            {return Center(child: CircularProgressIndicator(color: Colors.brown,));}
          else if (state is LoadedProd)
            {return SignInPage();}
          else{
            return Text(' فشل! حاول مجدداً لاحقاً ');
          }
        },),)
      ],
    );
  }
}
