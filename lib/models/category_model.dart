// lib/models/category.dart
/// نموذج بسيط لقسم Category
class Category {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final DateTime? createdAt;

  Category({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt:
      json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'image_url': imageUrl,
    'created_at': createdAt?.toIso8601String(),
  };
}
