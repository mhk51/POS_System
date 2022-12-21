import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item_builder.dart';
import 'package:objectbox/objectbox.dart';
import 'package:scanner_app/objectbox.g.dart';

@Entity()
class Item {
  @Id()
  int? id;
  final String name;
  final String? barcode;
  final int price;
  final int? cost;
  final int? stockCount;
  final int color;
  final int shape;
  final String? image;

  final category = ToOne<Category>();

  Item({
    this.id,
    this.barcode,
    required this.name,
    required this.price,
    this.stockCount,
    int? color,
    this.cost = 0,
    int? shape,
    this.image,
    Category? category,
  })  : color = color ?? Colors.grey.value,
        shape = shape ?? Icons.circle.codePoint {
    this.category.target = category;
  }

  factory Item.fromBuilder(ItemBuilder itemBuilder) {
    return Item(
      id: itemBuilder.id,
      name: itemBuilder.name!,
      price: itemBuilder.price!,
      barcode: itemBuilder.barcode,
      color: itemBuilder.color,
      cost: itemBuilder.cost,
      stockCount: itemBuilder.stockCount,
      image: itemBuilder.image?.path,
      shape: itemBuilder.shape.codePoint,
      category: itemBuilder.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "barcode": barcode,
      "name": name,
      "price": price,
      "cost": cost,
      "stock": stockCount,
      'color': color,
      "category": category.target?.name,
      "shape": shape,
      "image": image,
    };
  }

  @override
  String toString() {
    return "Name: $name, Category: $category, Price: $price, Cost: $cost, Barcode: $barcode, Stock: $stockCount, Shape: $shape, Color: $color";
  }
}
