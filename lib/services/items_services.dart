// import 'package:scanner_app/models/item.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:flutter/material.dart';

import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/objectbox.g.dart';
import 'package:scanner_app/services/open_store.dart';

class ItemServices {
  late final Store _store;
  static late final Box<Item> _boxItem;

  ItemServices._create(this._store) {
    _boxItem = Box<Item>(_store);
  }
  static Future<ItemServices> create() async {
    final store = await StoreService.create();
    return ItemServices._create(store);
  }

  static void insertItem(Item item) {
    _boxItem.put(item);
  }

  static void updateItem(Item item) {
    _boxItem.put(item, mode: PutMode.update);
  }

  static List<Item> getAllItems({int? categoryID}) {
    Condition<Item>? condition;
    if (categoryID != null) {
      condition = Item_.category.equals(categoryID);
    }
    return _boxItem.query(condition).build().find();
  }

  static Item? getItem(int? id) {
    if (id != null) {
      return _boxItem.get(id);
    }
    return null;
  }

  static Item? getItembyBarcode(String barcode) {
    return _boxItem.query(Item_.barcode.equals(barcode)).build().findFirst();
  }

  static void deleteItem(int? id) {
    if (id != null) {
      _boxItem.remove(id);
    }
  }
}
