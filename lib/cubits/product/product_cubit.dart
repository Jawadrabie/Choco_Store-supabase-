// lib/cubits/product/product_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product_model.dart';
import '../../repositories/product_repository.dart';
import '../../services/local_cache_service.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _repo;
  final LocalCacheService _cache;

  ProductCubit(this._repo, this._cache) : super(const ProductState());

  Future<void> loadFromCache() async {
    try {
      final cached = await _cache.loadProducts();
      if (cached.isNotEmpty) {
        emit(state.copyWith(products: cached, loadedFromCache: true));
      }
    } catch (e) {
      // ignore cache errors
    }
  }

  Future<void> loadFromNetwork() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final list = await _repo.getAllProducts();
      await _cache.saveProducts(list);
      emit(state.copyWith(products: list, isLoading: false, loadedFromCache: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> refresh() async {
    await loadFromNetwork();
  }

  /// مساعدة: جلب منتجات قسم معين من الشبكة (لا يؤثر على التخزين الكامل)
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    return await _repo.getProductsByCategory(categoryId);
  }
}
