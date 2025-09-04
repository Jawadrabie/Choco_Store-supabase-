import 'package:equatable/equatable.dart';
import '../../models/product_model.dart';

class ProductState extends Equatable {
  final List<Product> products;
  final bool isLoading;
  final String? error;
  final bool loadedFromCache;

  const ProductState({
    this.products = const [],
    this.isLoading = false,
    this.error,
    this.loadedFromCache = false,
  });

  ProductState copyWith({
    List<Product>? products,
    bool? isLoading,
    String? error,
    bool? loadedFromCache,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      loadedFromCache: loadedFromCache ?? this.loadedFromCache,
    );
  }

  @override
  List<Object?> get props => [products, isLoading, error, loadedFromCache];
}
