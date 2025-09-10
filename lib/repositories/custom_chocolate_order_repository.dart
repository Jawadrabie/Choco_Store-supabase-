import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/custom_chocolate_order_model.dart';

class CustomChocolateOrderRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<T> _withAuthRetry<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST303') {
        // JWT expired, try to refresh
        await _supabase.auth.refreshSession();
        return await operation();
      }
      rethrow;
    }
  }

  Future<CustomChocolateOrder> createCustomOrder({
    required String customerName,
    required String customerPhone,
    required String chocolateType,
    required List<String> ingredients,
    required String presentationType,
    required int weightGrams,
    String? notes,
  }) async {
    return await _withAuthRetry(() async {
      // حساب السعر الإجمالي
      final totalPrice = CustomChocolateOrder.calculatePrice(
        chocolateType: chocolateType,
        ingredients: ingredients,
        presentationType: presentationType,
        weightGrams: weightGrams,
      );

      // إنشاء الطلب
      final orderData = {
        'customer_name': customerName,
        'customer_phone': customerPhone,
        'chocolate_type': chocolateType,
        'ingredients': ingredients.join(','),
        'presentation_type': presentationType,
        'weight_grams': weightGrams,
        'notes': notes,
        'total_price': totalPrice,
        'status': 'pending',
      };

      final orderResponse = await _supabase
          .from('custom_chocolate_orders')
          .insert(orderData)
          .select()
          .single();

      return CustomChocolateOrder.fromJson(orderResponse);
    });
  }

  Future<List<CustomChocolateOrder>> getCustomOrders() async {
    return await _withAuthRetry(() async {
      final response = await _supabase
          .from('custom_chocolate_orders')
          .select()
          .order('created_at', ascending: false);

      return (response as List).map((json) => CustomChocolateOrder.fromJson(json)).toList();
    });
  }

  Future<CustomChocolateOrder?> getCustomOrderById(int orderId) async {
    return await _withAuthRetry(() async {
      final response = await _supabase
          .from('custom_chocolate_orders')
          .select()
          .eq('id', orderId)
          .single();

      return CustomChocolateOrder.fromJson(response);
    });
  }

  Future<void> updateCustomOrderStatus(int orderId, String status) async {
    await _withAuthRetry(() async {
      await _supabase
          .from('custom_chocolate_orders')
          .update({'status': status})
          .eq('id', orderId);
    });
  }
}





