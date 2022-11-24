import 'package:scanner_app/models/item.dart';
import 'package:sqflite/sqflite.dart';

class Services {
  static Future<Database> database = openDatabase(
    'items_database.db',
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE items(barcode TEXT PRIMARY KEY, name TEXT,price INTEGER)',
      );
    },
    version: 1,
  );

  static Future<void> dropTable() async {
    final db = await database;
    await db.delete('items');
  }

  static List<Item> itemsListfromMaps(List<Map<String, dynamic>> maps) {
    return List.generate(
      maps.length,
      (i) {
        return Item(
          currency: maps[i]['currency'],
          barcode: maps[i]['barcode'],
          name: maps[i]['name'],
          price: maps[i]['price'],
        );
      },
    );
  }

  static Future<void> insertItem(Item item) async {
    final db = await database;
    await db.insert('items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Item>> getAllItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('items');
    return itemsListfromMaps(maps);
  }

  static Future<Item> getItem(int barcode) async {
    final db = await database;
    List<Map<String, dynamic>> maps =
        await db.query('items', where: 'barcode = ?', whereArgs: [barcode]);
    List<Item> items = itemsListfromMaps(maps);
    return items.first;
  }

  static Future<void> updateItem(Item item) async {
    final db = await database;
    await db.update(
      'items',
      item.toMap(),
      where: 'barcode = ?',
      whereArgs: [item.barcode],
    );
  }
}
