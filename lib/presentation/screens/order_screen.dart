import 'package:flutter/material.dart';
import '../../shared_widget/custom_main_container.dart';
import 'custom_chocolate_customer_dialog.dart';
import '../../repositories/custom_chocolate_order_repository.dart';
import '../../models/custom_chocolate_order_model.dart';

class CustomChocolateOrderPage extends StatefulWidget {
  @override
  _CustomChocolateOrderPageState createState() =>
      _CustomChocolateOrderPageState();
}

class _CustomChocolateOrderPageState extends State<CustomChocolateOrderPage> {
  String? selectedChocolate;
  List<String> selectedIngredients = [];
  String? selectedPresentation;
  final TextEditingController weightController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  final List<String> chocolates = ["حليب", "دارك", "وايت", "بندق"];
  final List<String> ingredients = ["فستق", "بندق", "جوز الهند", "كراميل", "زبيب"];
  final List<String> presentations = ["بطاقة", "صندوق", "تغليف فاخر"];

  bool get isFormValid {
    return selectedChocolate != null &&
        selectedIngredients.isNotEmpty &&
        selectedPresentation != null &&
        weightController.text.isNotEmpty;
  }

  double get totalPrice {
    if (!isFormValid) return 0.0;
    
    return CustomChocolateOrder.calculatePrice(
      chocolateType: selectedChocolate!,
      ingredients: selectedIngredients,
      presentationType: selectedPresentation!,
      weightGrams: int.tryParse(weightController.text) ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    const brownFieldColor = Color(0xFF6C4A33); // بني للحقول
    const buttonColor = Color(0xFFD18656); // زر
    const whiteText = TextStyle(color: Colors.white);

    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: brownFieldColor, width: 2),
    );

    return Scaffold(resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFB8866E),
      appBar: AppBar(
        backgroundColor: Color(0xFFB8866E),
        elevation: 0,
        title: const Text("تواصي الشوكولا",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22)),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 🟤 نوع الشوكولا
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: brownFieldColor,
                  labelText: "اختر نوع الشوكولا",
                  labelStyle: whiteText,
                  enabledBorder: borderStyle,
                  focusedBorder: borderStyle,
                ),
                style: whiteText,
                dropdownColor: brownFieldColor,
                iconEnabledColor: Colors.white,
                value: selectedChocolate,
                items: chocolates.map((choco) {
                  return DropdownMenuItem(
                    value: choco,
                    child: Text(choco, style: whiteText),
                  );
                }).toList(),
                onChanged: (value) => setState(() => selectedChocolate = value),
              ),
              const SizedBox(height: 16),

              // 🟤 المكونات (حتى 3)
              InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: brownFieldColor,
                  labelText: "اختر المكونات (حتى 3)",
                  labelStyle: whiteText,
                  enabledBorder: borderStyle,
                  focusedBorder: borderStyle,
                ),
                child: Wrap(
                  spacing: 8,
                  children: ingredients.map((ingredient) {
                    final isSelected = selectedIngredients.contains(ingredient);
                    return FilterChip(
                      label: Text(ingredient, style: whiteText),
                      selected: isSelected,
                      selectedColor: buttonColor,
                      checkmarkColor: Colors.white,
                      backgroundColor: brownFieldColor,
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.white, width: 1.5),
                      ),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            if (selectedIngredients.length < 3) {
                              selectedIngredients.add(ingredient);
                            }
                          } else {
                            selectedIngredients.remove(ingredient);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),

              // 🟤 طريقة التقديم
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: brownFieldColor,
                  labelText: "طريقة التقديم",
                  labelStyle: whiteText,
                  enabledBorder: borderStyle,
                  focusedBorder: borderStyle,
                ),
                style: whiteText,
                dropdownColor: brownFieldColor,
                iconEnabledColor: Colors.white,
                value: selectedPresentation,
                items: presentations.map((present) {
                  return DropdownMenuItem(
                    value: present,
                    child: Text(present, style: whiteText),
                  );
                }).toList(),
                onChanged: (value) =>
                    setState(() => selectedPresentation = value),
              ),
              const SizedBox(height: 16),

              // 🟤 الوزن
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                style: whiteText,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: brownFieldColor,
                  labelText: "الوزن (غرام)",
                  labelStyle: whiteText,
                  enabledBorder: borderStyle,
                  focusedBorder: borderStyle,
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),

              // 🟤 الملاحظات
              TextField(
                controller: notesController,
                maxLines: 3,
                style: whiteText,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: brownFieldColor,
                  labelText: "ملاحظات إضافية (اختياري)",
                  labelStyle: whiteText,
                  enabledBorder: borderStyle,
                  focusedBorder: borderStyle,
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 20),

              // عرض السعر الإجمالي
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'السعر الإجمالي:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${totalPrice.toStringAsFixed(2)} \$',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 🟤 زر الطلب
        ElevatedButton(
          onPressed: isFormValid
              ? () => _handleCustomOrder(context)
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD18656), // لون بني فاتح
            padding: const EdgeInsets.symmetric(vertical: 16), // سماكة متناسقة
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // الحواف دائرية
            ),
            elevation: 0,
          ),
          child: const Text(
            "طلب المنتج",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleCustomOrder(BuildContext context) async {
    try {
      // عرض dialog لإدخال بيانات العميل
      final customerData = await showDialog<Map<String, String>>(
        context: context,
        barrierDismissible: false,
        builder: (context) => CustomChocolateCustomerDialog(
          chocolateType: selectedChocolate!,
          ingredients: selectedIngredients,
          presentationType: selectedPresentation!,
          weightGrams: int.parse(weightController.text),
          notes: notesController.text.isNotEmpty ? notesController.text : null,
          totalPrice: totalPrice,
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
          final orderRepository = CustomChocolateOrderRepository();
          final order = await orderRepository.createCustomOrder(
            customerName: customerData['name']!,
            customerPhone: customerData['phone']!,
            chocolateType: selectedChocolate!,
            ingredients: selectedIngredients,
            presentationType: selectedPresentation!,
            weightGrams: int.parse(weightController.text),
            notes: notesController.text.isNotEmpty ? notesController.text : null,
          );

          // إغلاق loading dialog
          Navigator.of(context).pop();

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
                  Text('نوع الشوكولا: ${order.chocolateType}'),
                  Text('الوزن: ${order.weightGrams} غرام'),
                  Text('السعر: ${order.totalPrice.toStringAsFixed(2)} \$'),
                  SizedBox(height: 8),
                  Text('سيتم التواصل معك قريباً'),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // إعادة تعيين النموذج
                    setState(() {
                      selectedChocolate = null;
                      selectedIngredients.clear();
                      selectedPresentation = null;
                      weightController.clear();
                      notesController.clear();
                    });
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
      print('Custom order cancelled: $e');
    }
  }
}
