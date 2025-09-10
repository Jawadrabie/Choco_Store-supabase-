import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/order_model.dart';
import '../screen/home_page_screen/home_page_model/prod_class.dart';

class OrderRepository {
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

  Future<Order> createOrder({
    required String customerName,
    required String customerPhone,
    required double totalAmount,
    required int totalItems,
    required Map<ProdInfo, int> cartItems,
  }) async {
    return await _withAuthRetry(() async {
      // إنشاء الطلب
      final orderData = {
        'customer_name': customerName,
        'customer_phone': customerPhone,
        'total_amount': totalAmount,
        'total_items': totalItems,
        'status': 'pending',
      };

      final orderResponse = await _supabase
          .from('orders')
          .insert(orderData)
          .select()
          .single();

      final order = Order.fromJson(orderResponse);

      // إنشاء تفاصيل الطلب
      final orderItems = cartItems.entries.map((entry) {
        final prod = entry.key;
        final quantity = entry.value;
        final priceStr = prod.price.replaceAll(RegExp(r'[^\d.]'), '');
        final price = double.tryParse(priceStr) ?? 0.0;
        
        return {
          'order_id': order.id,
          'product_name': prod.nameProd,
          'product_description': prod.description,
          'product_price': price,
          'quantity': quantity,
          'total_price': price * quantity,
        };
      }).toList();

      await _supabase.from('order_items').insert(orderItems);

      return order;
    });
  }

  Future<List<Order>> getOrders() async {
    return await _withAuthRetry(() async {
      final response = await _supabase
          .from('orders')
          .select()
          .order('created_at', ascending: false);

      return (response as List).map((json) => Order.fromJson(json)).toList();
    });
  }

  Future<Order?> getOrderById(int orderId) async {
    return await _withAuthRetry(() async {
      final response = await _supabase
          .from('orders')
          .select()
          .eq('id', orderId)
          .single();

      return Order.fromJson(response);
    });
  }

  Future<List<OrderItem>> getOrderItems(int orderId) async {
    return await _withAuthRetry(() async {
      final response = await _supabase
          .from('order_items')
          .select()
          .eq('order_id', orderId);

      return (response as List).map((json) => OrderItem.fromJson(json)).toList();
    });
  }

  Future<void> updateOrderStatus(int orderId, String status) async {
    await _withAuthRetry(() async {
      await _supabase
          .from('orders')
          .update({'status': status})
          .eq('id', orderId);
    });
  }
}





