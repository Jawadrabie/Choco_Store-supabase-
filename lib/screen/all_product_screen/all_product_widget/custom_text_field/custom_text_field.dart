import 'package:chocolate_store/screen/all_product_screen/all_product_widget/custom_text_field/cubit/text_field_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (nameProd){
      var  getProdInfo = BlocProvider.of<GetSearchProdCubit>(context);
      GetSearchProdCubit().GetProduct(prodName: 'prodName');
      },
      decoration: InputDecoration(
        labelText: 'البحث',
        labelStyle: TextStyle(color: Colors.white),
        suffixIcon: Icon(
          Icons.search,
          color: Colors.white,
        ),
        hintText: 'أدخل اسم المنتج',
        hintStyle: TextStyle(color: Colors.white60),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(35),
        ),
        focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(35),),
      ),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
    );
  }
}
