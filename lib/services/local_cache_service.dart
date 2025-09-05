import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../screen/home_page_screen/home_page_model/prod_class.dart';

class LocalCacheService {
  static const _categoriesKey = 'cached_categories';
  static const _productsKey = 'cached_products';
  static const _cartKey = 'cached_cart';
  static const _favoritesKey = 'cached_favorites';

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

  // حفظ السلة
  Future<void> saveCart(Map<ProdInfo, int> cart) async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = <String, dynamic>{};
    cart.forEach((product, quantity) {
      cartData[product.prodId.toString()] = {
        'product': product.toJson(),
        'quantity': quantity,
      };
    });
    await prefs.setString(_cartKey, jsonEncode(cartData));
  }

  // تحميل السلة
  Future<Map<ProdInfo, int>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString(_cartKey);
    if (cartString == null) return {};
    
    final cartData = jsonDecode(cartString) as Map<String, dynamic>;
    final cart = <ProdInfo, int>{};
    
    cartData.forEach((key, value) {
      final data = value as Map<String, dynamic>;
      final product = ProdInfo.fromJson(data['product'] as Map<String, dynamic>);
      final quantity = data['quantity'] as int;
      cart[product] = quantity;
    });
    
    return cart;
  }

  // حفظ المفضلة
  Future<void> saveFavorites(Set<int> favoriteIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, favoriteIds.map((id) => id.toString()).toList());
  }

  // تحميل المفضلة
  Future<Set<int>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteStrings = prefs.getStringList(_favoritesKey);
    if (favoriteStrings == null) return {};
    return favoriteStrings.map((s) => int.parse(s)).toSet();
  }
}
