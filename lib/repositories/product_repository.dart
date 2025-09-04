// lib/repositories/product_repository.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:postgrest/postgrest.dart';
import '../models/product_model.dart';

/// Repository للمنتجات. يعتمد على view `products_with_category`.
class ProductRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<T> _withAuthRetry<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on PostgrestException catch (e) {
      final isExpired = e.code == 'PGRST303' ||
          (e.message.toLowerCase().contains('jwt') &&
              e.message.toLowerCase().contains('expired'));
      if (!isExpired) rethrow;

      // حاول تحديث الجلسة ثم أعد المحاولة مرة واحدة
      try {
        await _client.auth.refreshSession();
      } catch (_) {
        // إذا فشل التحديث، أعد الخطأ الأصلي
        rethrow;
      }
      return await action();
    }
  }

  /// جميع المنتجات
  Future<List<Product>> getAllProducts() async {
    try {
      final data = await _withAuthRetry(() async {
        return await _client
            .from('products_with_category')
            .select()
            .order('created_at', ascending: false);
      });

      final list = (data as List).cast<dynamic>();
      return list
          .map((e) => Product.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (e) {
      throw Exception('خطأ عند جلب جميع المنتجات: $e');
    }
  }

  /// المنتجات حسب القسم
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    try {
      final data = await _withAuthRetry(() async {
        return await _client
            .from('products_with_category')
            .select()
            .eq('category_id', categoryId)
            .order('created_at', ascending: false);
      });

      final list = (data as List).cast<dynamic>();
      return list
          .map((e) => Product.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (e) {
      throw Exception('خطأ عند جلب منتجات القسم: $e');
    }
  }

  /// المنتجات الـ Trending
  Future<List<Product>> getTrendingProducts() async {
    try {
      final data = await _withAuthRetry(() async {
        return await _client
            .from('products_with_category')
            .select()
            .eq('is_trending', true)
            .order('created_at', ascending: false);
      });

      final list = (data as List).cast<dynamic>();
      return list
          .map((e) => Product.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (e) {
      throw Exception('خطأ عند جلب المنتجات الـ Trending: $e');
    }
  }

  /// المنتجات الـ Featured
  Future<List<Product>> getFeaturedProducts() async {
    try {
      final data = await _withAuthRetry(() async {
        return await _client
            .from('products_with_category')
            .select()
            .eq('is_featured', true)
            .order('created_at', ascending: false);
      });

      final list = (data as List).cast<dynamic>();
      return list
          .map((e) => Product.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (e) {
      throw Exception('خطأ عند جلب المنتجات الـ Featured: $e');
    }
  }
}
