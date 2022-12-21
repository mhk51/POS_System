import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:scanner_app/objectbox.g.dart';

@Entity()
class Category {
  final String name;
  int color;
  int items;
  @Id()
  int? id;

  Category(
    this.color, {
    required this.name,
    this.items = 0,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      'color': color,
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
