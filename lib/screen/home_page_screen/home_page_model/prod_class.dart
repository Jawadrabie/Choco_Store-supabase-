import 'package:flutter/material.dart';

class ProdInfo {
  int prodId;
  Image? image;
   String nameProd;
   String description;
   String price;
   bool isFavorite;

  ProdInfo(
      {required this.prodId,
         this.image,
        required this.nameProd,
        required this.description,
        required this.price,
      this.isFavorite = false,
      });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ProdInfo &&
              runtimeType == other.runtimeType &&
              prodId == other.prodId;

  @override
  int get hashCode => prodId.hashCode;

  // تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'prodId': prodId,
      'nameProd': nameProd,
      'description': description,
      'price': price,
      'isFavorite': isFavorite,
    };
  }

  // تحويل من JSON
  factory ProdInfo.fromJson(Map<String, dynamic> json) {
    return ProdInfo(
      prodId: json['prodId'] as int,
      nameProd: json['nameProd'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }
}
