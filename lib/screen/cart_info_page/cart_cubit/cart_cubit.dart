import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chocolate_store/screen/home_page_screen/home_page_model/prod_class.dart';
import '../../../services/local_cache_service.dart';

class CartCubit extends Cubit<Map<ProdInfo, int>> {
  final LocalCacheService _cacheService;

  CartCubit(this._cacheService) : super({}) {
    _loadCart();
  }

  // تحميل السلة من التخزين المحلي
  Future<void> _loadCart() async {
    try {
      final cart = await _cacheService.loadCart();
      emit(cart);
    } catch (e) {
      emit({});
    }
  }

  // حفظ السلة في التخزين المحلي
  Future<void> _saveCart(Map<ProdInfo, int> cart) async {
    try {
      await _cacheService.saveCart(cart);
    } catch (e) {
      // في حالة الخطأ، لا نوقف العملية
    }
  }

  void addToCart(ProdInfo product) {
    final current = Map<ProdInfo, int>.from(state);
    if (current.containsKey(product)) {
      current[product] = current[product]! + 1;
    } else {
      current[product] = 1;
    }
    emit(current);
    _saveCart(current);
  }

  void increaseQuantity(ProdInfo product) {
    final current = Map<ProdInfo, int>.from(state);
    if (current.containsKey(product)) {
      current[product] = current[product]! + 1;
      emit(current);
      _saveCart(current);
    }
  }

  void decreaseQuantity(ProdInfo product) {
    final current = Map<ProdInfo, int>.from(state);
    if (current.containsKey(product)) {
      if (current[product]! > 1) {
        current[product] = current[product]! - 1;
        emit(current);
        _saveCart(current);
      }
    }
  }

  void removeFromCart(ProdInfo product) {
    final current = Map<ProdInfo, int>.from(state);
    if (current.containsKey(product)) {
      current.remove(product);
      emit(current);
      _saveCart(current);
    }
  }

  void clearCart() {
    emit({});
    _saveCart({});
  }
}