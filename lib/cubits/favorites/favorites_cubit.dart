import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/local_cache_service.dart';

class FavoritesCubit extends Cubit<Set<int>> {
  final LocalCacheService _cacheService;

  FavoritesCubit(this._cacheService) : super({}) {
    _loadFavorites();
  }

  // تحميل المفضلة من التخزين المحلي
  Future<void> _loadFavorites() async {
    try {
      final favorites = await _cacheService.loadFavorites();
      emit(favorites);
    } catch (e) {
      emit({});
    }
  }

  // إضافة منتج للمفضلة
  Future<void> addToFavorites(int productId) async {
    try {
      final currentFavorites = Set<int>.from(state);
      currentFavorites.add(productId);
      await _cacheService.saveFavorites(currentFavorites);
      emit(currentFavorites);
    } catch (e) {
      // في حالة الخطأ، لا نحدث الحالة
    }
  }

  // إزالة منتج من المفضلة
  Future<void> removeFromFavorites(int productId) async {
    try {
      final currentFavorites = Set<int>.from(state);
      currentFavorites.remove(productId);
      await _cacheService.saveFavorites(currentFavorites);
      emit(currentFavorites);
    } catch (e) {
      // في حالة الخطأ، لا نحدث الحالة
    }
  }

  // تبديل حالة المفضلة (إضافة أو إزالة)
  Future<void> toggleFavorite(int productId) async {
    if (state.contains(productId)) {
      await removeFromFavorites(productId);
    } else {
      await addToFavorites(productId);
    }
  }

  // التحقق من كون المنتج في المفضلة
  bool isFavorite(int productId) {
    return state.contains(productId);
  }

  // مسح جميع المفضلة
  Future<void> clearFavorites() async {
    try {
      await _cacheService.saveFavorites({});
      emit({});
    } catch (e) {
      // في حالة الخطأ، لا نحدث الحالة
    }
  }
}
