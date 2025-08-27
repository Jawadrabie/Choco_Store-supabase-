import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chocolate_store/screen/home_page_screen/home_page_model/prod_class.dart';

class CartCubit extends Cubit<Map<ProdInfo, int>> {
  CartCubit() : super({});

  void addToCart(ProdInfo product) {
    final current = Map<ProdInfo, int>.from(state);
    if (current.containsKey(product)) {
      current[product] = current[product]! + 1;
    } else {
      current[product] = 1;
    }
    emit(current);
  }

  void increaseQuantity(ProdInfo product) {
    final current = Map<ProdInfo, int>.from(state);
    if (current.containsKey(product)) {
      current[product] = current[product]! + 1;
      emit(current); // يجب إصدار الحالة هنا بعد كل تعديل
    }
  }

  void decreaseQuantity(ProdInfo product) {
    final current = Map<ProdInfo, int>.from(state);
    if (current.containsKey(product)) {
      if (current[product]! > 1) {
        current[product] = current[product]! - 1;
      }
      emit(current);
    }
  }

  void removeFromCart(ProdInfo product) {
    final current = Map<ProdInfo, int>.from(state);
    if (current.containsKey(product)) {
      current.remove(product);
      emit(current);
    }
  }
}