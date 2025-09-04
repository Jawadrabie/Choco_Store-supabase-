import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class LocalCacheService {
  static const _categoriesKey = 'cached_categories';
  static const _productsKey = 'cached_products';

  // حفظ الأقسام
  Future<void> saveCategories(List<Category> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = categories.map((c) => jsonEncode(c.toJson())).toList();
    await prefs.setStringList(_categoriesKey, jsonList);
  }

  // تحميل الأقسام
  Future<List<Category>> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_categoriesKey);
    if (jsonList == null) return [];
    return jsonList
        .map((s) => Category.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList();
  }

  // حفظ المنتجات
  Future<void> saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = products.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList(_productsKey, jsonList);
  }

  // تحميل المنتجات
  Future<List<Product>> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_productsKey);
    if (jsonList == null) return [];
    return jsonList
        .map((s) => Product.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList();
  }
}
