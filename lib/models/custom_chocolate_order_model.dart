class CustomChocolateOrder {
  final int? id;
  final String customerName;
  final String customerPhone;
  final String chocolateType;
  final List<String> ingredients;
  final String presentationType;
  final int weightGrams;
  final String? notes;
  final double totalPrice;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CustomChocolateOrder({
    this.id,
    required this.customerName,
    required this.customerPhone,
    required this.chocolateType,
    required this.ingredients,
    required this.presentationType,
    required this.weightGrams,
    this.notes,
    required this.totalPrice,
    this.status = 'pending',
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'chocolate_type': chocolateType,
      'ingredients': ingredients.join(','), // تحويل القائمة إلى نص مفصول بفواصل
      'presentation_type': presentationType,
      'weight_grams': weightGrams,
      'notes': notes,
      'total_price': totalPrice,
      'status': status,
    };
  }

  factory CustomChocolateOrder.fromJson(Map<String, dynamic> json) {
    return CustomChocolateOrder(
      id: json['id'],
      customerName: json['customer_name'],
      customerPhone: json['customer_phone'],
      chocolateType: json['chocolate_type'],
      ingredients: (json['ingredients'] as String).split(',').where((e) => e.isNotEmpty).toList(),
      presentationType: json['presentation_type'],
      weightGrams: json['weight_grams'],
      notes: json['notes'],
      totalPrice: (json['total_price'] as num).toDouble(),
      status: json['status'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  // حساب السعر الإجمالي بناءً على الوزن والنوع
  static double calculatePrice({
    required String chocolateType,
    required List<String> ingredients,
    required String presentationType,
    required int weightGrams,
  }) {
    double basePrice = 0;
    
    // سعر الأساس حسب نوع الشوكولا (لكل 100 غرام)
    switch (chocolateType) {
      case 'حليب':
        basePrice = 15.0;
        break;
      case 'دارك':
        basePrice = 18.0;
        break;
      case 'وايت':
        basePrice = 16.0;
        break;
      case 'بندق':
        basePrice = 20.0;
        break;
      default:
        basePrice = 15.0;
    }
    
    // إضافة سعر المكونات (لكل مكون)
    double ingredientsPrice = ingredients.length * 3.0;
    
    // إضافة سعر طريقة التقديم
    double presentationPrice = 0;
    switch (presentationType) {
      case 'بطاقة':
        presentationPrice = 5.0;
        break;
      case 'صندوق':
        presentationPrice = 10.0;
        break;
      case 'تغليف فاخر':
        presentationPrice = 20.0;
        break;
    }
    
    // حساب السعر الإجمالي
    double pricePer100g = basePrice + ingredientsPrice;
    double totalPrice = (pricePer100g * weightGrams / 100) + presentationPrice;
    
    return totalPrice;
  }
}
