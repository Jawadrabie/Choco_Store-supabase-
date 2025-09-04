// lib/cubits/category/category_state.dart
import 'package:equatable/equatable.dart';
import '../../models/category_model.dart';

class CategoryState extends Equatable {
  final List<Category> categories;
  final bool isLoading;
  final String? error;
  final bool loadedFromCache; // true إذا عرضنا من الـ SharedPreferences

  const CategoryState({
    this.categories = const [],
    this.isLoading = false,
    this.error,
    this.loadedFromCache = false,
  });

  CategoryState copyWith({
    List<Category>? categories,
    bool? isLoading,
    String? error,
    bool? loadedFromCache,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      loadedFromCache: loadedFromCache ?? this.loadedFromCache,
    );
  }

  @override
  List<Object?> get props => [categories, isLoading, error, loadedFromCache];
}
