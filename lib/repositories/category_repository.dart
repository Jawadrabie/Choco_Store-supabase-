import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category_model.dart';

/// Repository لجلب الأقسام من Supabase
class CategoryRepository {
  final SupabaseClient _client = Supabase.instance.client;

  /// جلب كل الأقسام (من جدول public.categories)
  Future<List<Category>> getAllCategories() async {
    try {
      final data = await _client
          .from('categories')
          .select()
          .order('created_at', ascending: false);

      // data هنا عبارة عن List<dynamic>
      final list = (data as List).cast<dynamic>();
      return list
          .map((e) => Category.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (e) {
      throw Exception('خطأ عند جلب الأقسام: $e');
    }
  }
}
