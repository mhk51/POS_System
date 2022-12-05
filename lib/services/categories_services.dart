// import 'package:scanner_app/models/category.dart';
// import 'package:sqflite/sqflite.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scanner_app/models/category.dart';

class CategoriesServices {
  static CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

  static Future<void> insertCategory(Category category) async {
    await categoriesCollection.doc().set(category.toMap());
  }

  static List<Category> categoriesFromSnapshot(QuerySnapshot snapshot) {
    List<DocumentSnapshot> docs = snapshot.docs;
    return docs
        .map(
          (doc) => Category(
            name: doc.get('name'),
            color: Color(doc.get('color')),
          ),
        )
        .toList();
  }

  static Stream<List<Category>> get categories {
    return categoriesCollection.snapshots().map(categoriesFromSnapshot);
  }

  static Future<List<Category>> getAllCategories() async {
    QuerySnapshot snapshot = await categoriesCollection.get();
    return categoriesFromSnapshot(snapshot);
  }

  static Future<Category?> getCategory(String? name) async {
    if (name == null) return null;
    DocumentSnapshot doc = await categoriesCollection.doc(name).get();
    return Category(
      name: doc.get('name'),
      color: Color(doc.get('color')),
    );
  }

  static Future<void> updateCategory(Category category) async {
    await categoriesCollection.doc(category.name).update(category.toMap());
  }

  static Future<void> deleteCategory(Category category) async {
    await categoriesCollection.doc(category.name).delete();
  }
}
// class CategoriesServices {
//   static Future<Database> database = openDatabase(
//     'categories_database.db',
//     onCreate: (db, version) async {
//       return await db.execute(
//         '''CREATE TABLE categories(
//         id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
//         name TEXT,
//         color INTEGER
//         )''',
//       );
//     },
//     version: 2,
//   );

//   static Future<void> dropTable() async {
//     final db = await database;
//     await db.delete('categories');
//     await db.execute('DROP TABLE categories');
//   }

//   static List<Category> categoriessListfromMaps(
//       List<Map<String, dynamic>> maps) {
//     return List.generate(
//       maps.length,
//       (i) {
//         return Category(
//           id: maps[i]['id'],
//           name: maps[i]['name'],
//           color: maps[i]['color'],
//         );
//       },
//     );
//   }

//   static Future<void> insertCategory(Category category) async {
//     final db = await database;
//     await db.insert('categories', category.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   static Future<List<Category>> getAllCategories() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('categories');
//     return categoriessListfromMaps(maps);
//   }

//   static Future<Category> getCategory(String name) async {
//     final db = await database;
//     List<Map<String, dynamic>> maps =
//         await db.query('categories', where: 'name = ?', whereArgs: [name]);
//     List<Category> categories = categoriessListfromMaps(maps);
//     return categories.first;
//   }

//   static Future<void> updateCategory(Category category) async {
//     final db = await database;
//     await db.update(
//       'categories',
//       category.toMap(),
//       where: 'id = ?',
//       whereArgs: [category.id],
//     );
//   }

//   static Future<void> deleteCategory(Category category) async {
//     final db = await database;
//     await db.delete('categories', where: 'id = ?', whereArgs: [category.id]);
//   }
// }
