import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scanner_app/models/category.dart';

class Item {
  final String name;
  final String? barcode;
  final int price;
  final int? cost;
  final int? stockCount;
  final Color color;
  final IconData shape;
  final Category? category;
  final File? image;

  Item({
    this.barcode,
    required this.name,
    required this.price,
    this.stockCount,
    this.category,
    this.color = Colors.grey,
    this.cost = 0,
    this.shape = Icons.circle,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      "barcode": barcode,
      "name": name,
      "price": price,
      "cost": cost,
      "stock": stockCount,
      'color': color.value,
      "category": category?.name,
      "shape": shape.codePoint,
      "image": image?.path,
    };
  }

  @override
  String toString() {
    return "Name: $name, Category: $category, Price: $price, Cost: $cost, Barcode: $barcode, Stock: $stockCount, Shape: $shape, Color: $color";
  }
}
