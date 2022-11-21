import 'package:scanner_app/item.dart';
import 'package:sqflite/sqflite.dart';

class Services {
  static String databasePath = 'items_database.db';
  // final database = openDatabase();

  static Future<void> createTable() async {
    final database = await openDatabase(databasePath);
    await database.execute(
      'CREATE TABLE items(barcode TEXT PRIMARY KEY, name TEXT,price INTEGER)',
    );
  }

  static Future<void> dropTable() async {
    final database = await openDatabase(databasePath);
    database.delete('items');
  }

  static List<Item> itemsListfromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(
      maps.length,
      (i) {
        return Item(
          barcode: maps[i]['barcode'],
          name: maps[i]['name'],
          price: maps[i]['price'],
        );
      },
    );
  }

  static Future<void> insertItem(Item item) async {
    final database = await openDatabase(databasePath);
    await database.insert('items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Item>> getAllItems() async {
    final database = await openDatabase(databasePath);
    final List<Map<String, dynamic>> maps = await database.query('items');
    return itemsListfromMaps(maps);
  }

  static Future<Item> getItem(int barcode) async {
    final database = await openDatabase(databasePath);
    List<Map<String, dynamic>> maps = await database
        .query('items', where: 'barcode = ?', whereArgs: [barcode]);
    List<Item> items = itemsListfromMaps(maps);
    return items.first;
  }

  static Future<void> updateItem(Item item) async {
    final database = await openDatabase(databasePath);
    await database.update(
      'items',
      item.toMap(),
      where: 'barcode = ?',
      whereArgs: [item.barcode],
    );
  }
}
