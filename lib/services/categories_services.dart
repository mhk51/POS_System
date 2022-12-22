// import 'package:scanner_app/models/category.dart';
// import 'package:sqflite/sqflite.dart';

import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/objectbox.g.dart';
import 'package:scanner_app/services/open_store.dart';

class CategoriesServices {
  late final Store _store;
  static late final Box<Category> _boxCategory;

  CategoriesServices._create(this._store) {
    _boxCategory = Box<Category>(_store);
  }
  static Future<CategoriesServices> create() async {
    final store = await StoreService.create();
    return CategoriesServices._create(store);
  }

  static void insertCategory(Category category) {
    _boxCategory.put(category);
  }

  static List<Category> getAllCategories() {
    return _boxCategory.getAll();
  }

  static Stream<List<Category>> get getCategories {
    final qBuilderTasks = _boxCategory.query();
    return qBuilderTasks
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }

  static void updateCategory(Category category) {
    _boxCategory.put(category, mode: PutMode.update);
  }

  static void deleteCategory(Category category) {
    _boxCategory.remove(category.id!);
  }
}
