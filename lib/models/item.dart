// ignore_for_file: constant_identifier_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scanner_app/models/category.dart';

enum RepresentationType { Shape, Image }

class Item extends ChangeNotifier {
  int? stockCount;
  int? price;
  int cost;
  String? barcode;
  String? name;
  Color color;
  IconData shape;
  Category? category;
  File? image;

  Item({
    this.barcode,
    this.name,
    this.price,
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

  void updateStock(int stock) {
    stockCount = stock;
  }

  void updateColor(Color color) {
    this.color = color;
  }

  void updatePrice(int price) {
    this.price = price;
  }

  void updateBarcode(String barcode) {
    this.barcode = barcode;
  }

  void updateShape(IconData iconData) {
    shape = iconData;
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
