// lib/screen/cart_info_page/cart_info_page.dart
import 'package:chocolate_store/screen/home_page_screen/home_page_model/prod_class.dart';
import 'package:chocolate_store/shared_widget/custom_main_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_cubit/cart_cubit.dart';
import 'cart_info_widget/your_order_list.dart';
import 'customer_info_dialog.dart';
import '../../repositories/order_repository.dart';

class CartInfoPage extends StatelessWidget {
  const CartInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFD6C0B0),
        appBar: AppBar(
          backgroundColor: const Color(0xFFD6C0B0),
          elevation: 0,
          leading: BackButton(color: Colors.black),
          title: const Text(
            'سلة تسوقك',
            style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CartCubit, Map<ProdInfo, int>>(
          builder: (context, cartMap) {
            if (cartMap.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'السلة فارغة',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'أضف بعض المنتجات لتبدأ التسوق',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              );
            }

            final entries = cartMap.entries.toList();
            final totalItems = cartMap.values.fold(0, (sum, quantity) => sum + quantity);
            final totalPrice = cartMap.entries.fold(0.0, (sum, entry) {
              // entry.key.price is string like "12.00 $" - نزيل أي أحرف غير الأرقام والنقطة
              final priceStr = entry.key.price.replaceAll(RegExp(r'[^\d\.]'), '');
              final price = double.tryParse(priceStr) ?? 0.0;
              return sum + (price * entry.value);
            });

            return Column(
              children: [
                // إحصائيات السلة
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // إحصائيات (أرقام)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'إجمالي العناصر: $totalItems',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'المجموع: ${totalPrice.toStringAsFixed(2)} \$',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[700],
                            ),
                          ),
                        ],
                      ),
                                             ElevatedButton(
                         onPressed: () async {
                           await _handleCheckout(context, cartMap, totalPrice, totalItems);
                         },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[700],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text('إتمام الطلب'),
                      ),
                    ],
                  ),
                ),

                // قائمة المنتجات
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final prod = entries[index].key;
                      final quantity = entries[index].value;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              // صف الصورة + التفاصيل
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      width: 65,
                                      height: 65,
                                      child: prod.image ??
                                          Image.asset(
                                            'asset/image/main_image.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  // تفاصيل المنتج: اسم، وصف، سعر
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          prod.nameProd,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          prod.description,
                                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          prod.price,
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.brown[700]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              // أزرار التحكم: كمية + حذف
                              Row(
                                children: [
                                  // مجموعة أزرار الكمية (لا تشغل مساحة أكبر من اللازم)
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // زر إنقاص
                                        InkWell(
                                          onTap: () {
                                            context.read<CartCubit>().decreaseQuantity(prod);
                                          },
                                          borderRadius: BorderRadius.circular(6),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            child: const Icon(Icons.remove_circle_outline, size: 22, color: Colors.brown),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        // عدد العناصر
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: Colors.brown[100],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            '$quantity',
                                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        // زر زيادة
                                        InkWell(
                                          onTap: () {
                                            context.read<CartCubit>().increaseQuantity(prod);
                                          },
                                          borderRadius: BorderRadius.circular(6),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            child: const Icon(Icons.add_circle_outline, size: 22, color: Colors.brown),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Spacer يفصل بين عناصر الكمية وزر الحذف ويدفع زر الحذف لليمين
                                  const Spacer(),

                                  // زر الحذف (ثابت الحجم على اليمين)
                                  InkWell(
                                    onTap: () {
                                      context.read<CartCubit>().removeFromCart(prod);
                                    },
                                    borderRadius: BorderRadius.circular(6),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: const Icon(Icons.delete_outline, color: Colors.red, size: 22),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _handleCheckout(
    BuildContext context,
    Map<ProdInfo, int> cartMap,
    double totalPrice,
    int totalItems,
  ) async {
    try {
      // عرض dialog لإدخال بيانات العميل
      final customerData = await showDialog<Map<String, String>>(
        context: context,
        barrierDismissible: false,
        builder: (context) => CustomerInfoDialog(
          totalAmount: totalPrice,
          totalItems: totalItems,
        ),
      );

      if (customerData != null) {
        // إظهار loading
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.brown[700]),
                    SizedBox(height: 16),
                    Text('جاري إرسال الطلب...'),
                  ],
                ),
              ),
            ),
          ),
        );

        try {
          // إنشاء الطلب في قاعدة البيانات
          final orderRepository = OrderRepository();
          final order = await orderRepository.createOrder(
            customerName: customerData['name']!,
            customerPhone: customerData['phone']!,
            totalAmount: totalPrice,
            totalItems: totalItems,
            cartItems: cartMap,
          );

          // إغلاق loading dialog
          Navigator.of(context).pop();

          // إفراغ السلة
          context.read<CartCubit>().clearCart();

          // إظهار رسالة نجاح
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text('تم إرسال الطلب بنجاح'),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('رقم الطلب: ${order.id}'),
                  SizedBox(height: 8),
                  Text('سيتم التواصل معك قريباً'),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(); // العودة للصفحة السابقة
                  },
                  child: Text('حسناً'),
                ),
              ],
            ),
          );
        } catch (e) {
          // إغلاق loading dialog
          Navigator.of(context).pop();
          
          // إظهار رسالة خطأ
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(width: 8),
                  Text('خطأ في إرسال الطلب'),
                ],
              ),
              content: Text('حدث خطأ أثناء إرسال الطلب. يرجى المحاولة مرة أخرى.'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('حسناً'),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      // في حالة إلغاء العملية
      print('Checkout cancelled: $e');
    }
  }
}
