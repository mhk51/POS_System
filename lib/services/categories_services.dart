import 'package:scanner_app/models/category.dart';
import 'package:sqflite/sqflite.dart';

class CategoriesServices {
  static Future<Database> database = openDatabase(
    'categories_database.db',
    onCreate: (db, version) async {
      return await db.execute(
        'CREATE TABLE categories(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,name TEXT, color INTEGER, items INTEGER)',
      );
    },
    version: 2,
  );

  static Future<void> dropTable() async {
    final db = await database;
    await db.delete('categories');
    await db.execute('DROP TABLE categories');
  }

  static List<Category> categoriessListfromMaps(
      List<Map<String, dynamic>> maps) {
    return List.generate(
      maps.length,
      (i) {
        return Category(
          id: maps[i]['id'],
          name: maps[i]['name'],
          color: maps[i]['color'],
          items: maps[i]['items'],
        );
      },
    );
  }

  static Future<void> insertCategory(Category category) async {
    final db = await database;
    await db.insert('categories', category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Category>> getAllCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('categories');
    return categoriessListfromMaps(maps);
  }

  static Future<Category> getCategory(String name) async {
    final db = await database;
    List<Map<String, dynamic>> maps =
        await db.query('categories', where: 'name = ?', whereArgs: [name]);
    List<Category> categories = categoriessListfromMaps(maps);
    return categories.first;
  }

  static Future<void> updateCategory(Category category) async {
    final db = await database;
    await db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }
}
