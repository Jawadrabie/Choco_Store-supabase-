import 'package:flutter/material.dart';

class CustomerInfoDialog extends StatefulWidget {
  final double totalAmount;
  final int totalItems;

  const CustomerInfoDialog({
    super.key,
    required this.totalAmount,
    required this.totalItems,
  });

  @override
  State<CustomerInfoDialog> createState() => _CustomerInfoDialogState();
}

class _CustomerInfoDialogState extends State<CustomerInfoDialog> {
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
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(Icons.shopping_cart, color: Colors.brown[700]),
          SizedBox(width: 8),
          Text(
            'إتمام الطلب',
            style: TextStyle(
              color: Colors.brown[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ملخص الطلب
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.brown[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.brown[200]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'إجمالي العناصر: ${widget.totalItems}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'المجموع: ${widget.totalAmount.toStringAsFixed(2)} \$',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[700],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            
            // حقل الاسم
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'الاسم الكامل',
                prefixIcon: Icon(Icons.person, color: Colors.brown[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.brown[700]!, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'يرجى إدخال الاسم';
                }
                if (value.trim().length < 3) {
                  return 'الاسم يجب أن يكون 3 أحرف على الأقل';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            
            // حقل رقم الهاتف
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'رقم الهاتف',
                prefixIcon: Icon(Icons.phone, color: Colors.brown[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.brown[700]!, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'يرجى إدخال رقم الهاتف';
                }
                if (value.trim().length < 8) {
                  return 'رقم الهاتف غير صحيح';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        // زر الإلغاء
        TextButton(
          onPressed: _isSubmitting ? null : () {
            Navigator.of(context).pop();
          },
          child: Text(
            'إلغاء',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        
        // زر التأكيد
        ElevatedButton(
          onPressed: _isSubmitting ? null : () async {
            if (_formKey.currentState!.validate()) {
              setState(() {
                _isSubmitting = true;
              });
              
              // إرجاع البيانات للمستدعي
              Navigator.of(context).pop({
                'name': _nameController.text.trim(),
                'phone': _phoneController.text.trim(),
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown[700],
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _isSubmitting
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text('تأكيد الطلب'),
        ),
      ],
    );
  }
}
