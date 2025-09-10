// lib/presentation/screens/custom_chocolate_customer_dialog.dart
import 'package:flutter/material.dart';

class CustomChocolateCustomerDialog extends StatefulWidget {
  final String chocolateType;
  final List<String> ingredients;
  final String presentationType;
  final int weightGrams;
  final String? notes;
  final double totalPrice;

  const CustomChocolateCustomerDialog({
    super.key,
    required this.chocolateType,
    required this.ingredients,
    required this.presentationType,
    required this.weightGrams,
    this.notes,
    required this.totalPrice,
  });

  @override
  State<CustomChocolateCustomerDialog> createState() => _CustomChocolateCustomerDialogState();
}

class _CustomChocolateCustomerDialogState extends State<CustomChocolateCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // نحدد أقصى ارتفاع للـ dialog كنسبة من شاشة الجهاز
    final maxHeight = MediaQuery.of(context).size.height * 0.6;
    final brown700 = Colors.brown[700]!;
    final brown50 = Colors.brown[50]!;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(Icons.cake, color: brown700),
          const SizedBox(width: 8),
          Text(
            'طلب شوكولا مخصصة',
            style: TextStyle(color: brown700, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: SingleChildScrollView(
        // هذا يضمن أن المحتوى قابل للتمرير داخل الـ dialog
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisSize.min + التمرير يضمنان عدم overflow
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ملخص الطلب
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: brown50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.brown.shade200),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('تفاصيل الطلب:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('نوع الشوكولا: ${widget.chocolateType}'),
                        Text('المكونات: ${widget.ingredients.join(", ")}'),
                        Text('طريقة التقديم: ${widget.presentationType}'),
                        Text('الوزن: ${widget.weightGrams} غرام'),
                        if (widget.notes != null && widget.notes!.isNotEmpty) Text('ملاحظات: ${widget.notes}'),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('السعر الإجمالي:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                            Text('${widget.totalPrice.toStringAsFixed(2)} \$', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: brown700)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // حقل الاسم
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'الاسم الكامل',
                    prefixIcon: Icon(Icons.person, color: Colors.brown[600]),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: brown700, width: 2)),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'يرجى إدخال الاسم';
                    if (value.trim().length < 3) return 'الاسم يجب أن يكون 3 أحرف على الأقل';
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // حقل الهاتف
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'رقم الهاتف',
                    prefixIcon: Icon(Icons.phone, color: Colors.brown[600]),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: brown700, width: 2)),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'يرجى إدخال رقم الهاتف';
                    if (value.trim().length < 6) return 'رقم الهاتف غير صحيح';
                    return null;
                  },
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),

      // الأزرار أسفل الـ dialog
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
          child: Text('إلغاء', style: TextStyle(color: Colors.grey[600])),
        ),
        ElevatedButton(
          onPressed: _isSubmitting
              ? null
              : () {
            if (_formKey.currentState!.validate()) {
              setState(() => _isSubmitting = true);
              // نرجع البيانات للمستدعي
              Navigator.of(context).pop({
                'name': _nameController.text.trim(),
                'phone': _phoneController.text.trim(),
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: brown700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: _isSubmitting
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Color(0xFFBD9872), strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
              : const Text('تأكيد الطلب'),
        ),
      ],
    );
  }
}
