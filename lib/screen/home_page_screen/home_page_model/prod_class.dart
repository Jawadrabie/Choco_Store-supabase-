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
}
