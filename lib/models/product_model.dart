// lib/models/product.dart
/// نموذج لمنتج Product — يعتمد على view products_with_category
class Product {
  final String id;
  final String categoryId;
  final String categoryName; // اسم القسم (مهم لعرضه مباشرة)
  final String name; // product_name من الـ view
  final String? description;
  final double price;
  final String? imageUrl;
  final int inStock;
  final bool isFeatured;
  final bool isTrending;
  final DateTime? createdAt;

  Product({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
    required this.inStock,
    required this.isFeatured,
    required this.isTrending,
    this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    double parsePrice(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    int parseInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      return int.tryParse(v.toString()) ?? 0;
    }

    return Product(
      id: json['id'] as String,
      categoryId: json['category_id'] as String,
      categoryName: (json['category_name'] ?? '') as String,
      name: (json['product_name'] ?? json['name'] ?? '') as String,
      description: json['description'] as String?,
      price: parsePrice(json['price']),
      imageUrl: json['image_url'] as String?,
      inStock: parseInt(json['in_stock']),
      isFeatured: json['is_featured'] == true || json['is_featured'].toString() == 'true',
      isTrending: json['is_trending'] == true || json['is_trending'].toString() == 'true',
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'category_id': categoryId,
    'category_name': categoryName,
    'product_name': name,
    'description': description,
    'price': price,
    'image_url': imageUrl,
    'in_stock': inStock,
    'is_featured': isFeatured,
    'is_trending': isTrending,
    'created_at': createdAt?.toIso8601String(),
  };
}
