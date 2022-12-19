// import 'package:scanner_app/models/item.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:flutter/material.dart';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/services/categories_services.dart';

class ItemServices {
  static CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('items');

  static Future<void> insertItem(Item item) async {
    await itemsCollection
        .doc(item.barcode)
        .set(item.toMap(), SetOptions(merge: true));
  }

  static Item itemFromSnapshot(
      DocumentSnapshot snapshot, List<Category> categories) {
    String? imageFile = snapshot.get('image');
    String? categoryName = snapshot.get('category');
    Category? category;
    if (categoryName != null) {
      for (Category elem in categories) {
        if (elem.name == categoryName) {
          category = elem;
        }
      }
    }
    return Item(
      barcode: snapshot.get('barcode') ?? snapshot.id,
      name: snapshot.get('name'),
      price: snapshot.get('price'),
      cost: snapshot.get('cost'),
      color: Color(snapshot.get('color')),
      shape: IconData(snapshot.get('shape'), fontFamily: "MaterialIcons"),
      stockCount: snapshot.get('stock'),
      category: category,
      image: imageFile != null ? File(imageFile) : null,
    );
  }

  static Future<List<Item>> getAllItems({String? categoryName}) async {
    QuerySnapshot snapshot =
        await itemsCollection.where('category', isEqualTo: categoryName).get();
    List<Category> categories = await CategoriesServices.getAllCategories();
    List<DocumentSnapshot> docs = snapshot.docs;
    return docs.map((e) {
      return itemFromSnapshot(e, categories);
    }).toList();
  }

  static Future<Item?> getItem(String barcode) async {
    DocumentSnapshot snapshot = await itemsCollection.doc(barcode).get();
    if (snapshot.exists) {
      List<Category> categories = await CategoriesServices.getAllCategories();
      return itemFromSnapshot(snapshot, categories);
    } else {
      return null;
    }
  }

  static Future<void> deleteItem(String barcode) async {
    await itemsCollection.doc(barcode).delete();
  }
}
// class ItemServices {
//   static Future<Database> database = openDatabase(
//     'items_database.db',
//     onCreate: (db, version) {
//       // Run the CREATE TABLE statement on the database.
//       return db.execute(
//         '''CREATE TABLE items(
//           barcode TEXT PRIMARY KEY NOT NULL,
//           name TEXT NOT NULL,
//           price INTEGER NOT NULL,
//           cost INTEGER,
//           stockCount INTEGER,
//           color INTEGER NOT NULL,
//           shape INTEGER NOT NULL),
//           category INTEGER,
//           FOREIGN KEY(category) REFERENCES categories(id)
//           ''',
//       );
//     },
//     version: 1,
//   );

//   static Future<void> dropTable() async {
//     final db = await database;
//     await db.delete('items');
//   }

//   static List<Item> itemsListfromMaps(List<Map<String, dynamic>> maps) {
//     return List.generate(
//       maps.length,
//       (i) {
//         return Item(
//           barcode: maps[i]['barcode'],
//           name: maps[i]['name'],
//           price: maps[i]['price'],
//           category: maps[i]['category'],
//           cost: maps[i]['cost'],
//           stockCount: maps[i]['stockCount'],
//           color: Color(maps[i]['cost']),
//           shape: IconData(maps[i]['shape']),
//         );
//       },
//     );
//   }

//   static Future<void> insertItem(Item item) async {
//     final db = await database;
//     await db.insert('items', item.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   static Future<List<Item>> getAllItems() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('items');
//     return itemsListfromMaps(maps);
//   }

//   static Future<Item> getItem(int barcode) async {
//     final db = await database;
//     List<Map<String, dynamic>> maps =
//         await db.query('items', where: 'barcode = ?', whereArgs: [barcode]);
//     List<Item> items = itemsListfromMaps(maps);
//     return items.first;
//   }

//   static Future<void> updateItem(Item item) async {
//     final db = await database;
//     await db.update(
//       'items',
//       item.toMap(),
//       where: 'barcode = ?',
//       whereArgs: [item.barcode],
//     );
//   }
// }
