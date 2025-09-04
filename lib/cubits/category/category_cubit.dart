import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/category_model.dart';
import '../../repositories/category_repository.dart';
import '../../services/local_cache_service.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository _repo;
  final LocalCacheService _cache;

  CategoryCubit(this._repo, this._cache) : super(const CategoryState());

  /// تحميل الأقسام من الكاش (SharedPreferences)
  Future<void> loadFromCache() async {
    try {
      final cached = await _cache.loadCategories();
      if (cached.isNotEmpty) {
        emit(state.copyWith(categories: cached, loadedFromCache: true));
      }
    } catch (e) {
      // تجاهل أخطاء الكاش
    }
  }

  /// تحميل الأقسام من السيرفر
  Future<void> loadFromNetwork() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final list = await _repo.getAllCategories();
      await _cache.saveCategories(list);
      emit(state.copyWith(categories: list, isLoading: false, loadedFromCache: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// تحديث يدوي (Refresh)
  Future<void> refresh() async {
    await loadFromNetwork();
  }
}
