class Order {
  final int? id;
  final String customerName;
  final String customerPhone;
  final double totalAmount;
  final int totalItems;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Order({
    this.id,
    required this.customerName,
    required this.customerPhone,
    required this.totalAmount,
    required this.totalItems,
    this.status = 'pending',
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'total_amount': totalAmount,
      'total_items': totalItems,
      'status': status,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customerName: json['customer_name'],
      customerPhone: json['customer_phone'],
      totalAmount: (json['total_amount'] as num).toDouble(),
      totalItems: json['total_items'],
      status: json['status'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }
}

class OrderItem {
  final int? id;
  final int? orderId;
  final String productName;
  final String? productDescription;
  final double productPrice;
  final int quantity;
  final double totalPrice;

  OrderItem({
    this.id,
    this.orderId,
    required this.productName,
    this.productDescription,
    required this.productPrice,
    required this.quantity,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      if (orderId != null) 'order_id': orderId,
      'product_name': productName,
      'product_description': productDescription,
      'product_price': productPrice,
      'quantity': quantity,
      'total_price': totalPrice,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      orderId: json['order_id'],
      productName: json['product_name'],
      productDescription: json['product_description'],
      productPrice: (json['product_price'] as num).toDouble(),
      quantity: json['quantity'],
      totalPrice: (json['total_price'] as num).toDouble(),
    );
  }
}





