// ignore_for_file: constant_identifier_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';

class ItemBuilder extends ChangeNotifier {
  int? id;
  String? barcode;
  String? name;
  int? price;
  int cost;
  int? stockCount;
  int color;
  IconData shape;
  Category? category;
  File? image;

  ItemBuilder({
    this.id,
    this.barcode,
    this.name,
    this.price,
    this.stockCount,
    this.category,
    int? color,
    this.cost = 0,
    this.shape = Icons.circle,
    this.image,
  }) : color = color ?? Colors.grey.value;

  factory ItemBuilder.fromItem(Item item) {
    return ItemBuilder(
      id: item.id,
      barcode: item.barcode,
      name: item.name,
      price: item.price,
      stockCount: item.stockCount,
      category: item.category.target,
      color: item.color,
      cost: item.cost ?? 0,
      shape: IconData(item.shape, fontFamily: "MaterialIcons"),
      image: item.image != null ? File(item.image!) : null,
    );
  }

  bool validate() {
    return name != null;
  }

  Map<String, dynamic> toMap() {
    return {
      "barcode": barcode,
      "name": name,
      "price": price,
      "cost": cost,
      "stock": stockCount,
      'color': color,
      "category": category?.name,
      "shape": shape.codePoint,
      "image": image?.path,
    };
  }

  void updateStock(int stock) {
    stockCount = stock;
  }

  void updateColor(int color) {
    this.color = color;
    image = null;
  }

  void updatePrice(int price) {
    this.price = price;
  }

  void updateBarcode(String barcode) {
    this.barcode = barcode;
  }

  void updateShape(IconData iconData) {
    shape = iconData;
    image = null;
  }

  void updateCategory(Category? category) {
    this.category = category;
  }

  void updateCost(int cost) {
    this.cost = cost;
  }

  void updateName(String name) {
    this.name = name;
  }

  void updateImage(File? file) {
    image = file;
  }

  void update() {
    notifyListeners();
  }

  @override
  String toString() {
    return "Name: $name, Category: $category, Price: $price, Cost: $cost, Barcode: $barcode, Stock: $stockCount, Shape: $shape, Color: $color";
  }
}
