import 'package:flutter/material.dart';

class Category {
  final String name;
  final Color color;
  int items;

  Category({
    required this.name,
    required this.color,
    this.items = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      'color': color.value,
      'items': items,
    };
  }

  @override
  String toString() {
    return 'Category{name: $name, color: $color, items: $items}';
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is Category && name == other.name;
}
