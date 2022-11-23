// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum Currency { USD, LPB }

class Item {
  final String barcode;
  final String name;
  final double price;
  double? cost;
  Color? color;

  Item({required this.barcode, required this.name, required this.price});

  Map<String, dynamic> toMap() {
    return {"barcode": barcode, "name": name, "price": price, 'color': color};
  }

  @override
  String toString() {
    return 'Item{barcode: $barcode, name: $name, price: $price}';
  }
}

class Category {}
