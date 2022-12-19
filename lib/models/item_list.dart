import 'package:flutter/cupertino.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/services/categories_services.dart';
import 'package:scanner_app/services/items_services.dart';

class ItemList extends ChangeNotifier {
  List<Item> items = [];
  List<Item> _allItems = [];
  List<Category> categories = [];
  bool loading = true;
  Category? selectedCategory;
  String searchWord = "";
  ItemList() {
    load();
  }

  Future<void> load() async {
    loading = true;
    notifyListeners();
    List<Future> futures = [
      CategoriesServices.getAllCategories(),
      ItemServices.getAllItems(categoryName: selectedCategory?.name),
    ];

    List reponses = await Future.wait(futures);
    categories = reponses[0];
    _allItems = reponses[1];
    items = _filter();

    loading = false;
    notifyListeners();
  }

  List<Item> _filter() {
    List<Item> result = [];
    for (Item item in _allItems) {
      if (selectedCategory == null || item.category == selectedCategory) {
        if (item.name.startsWith(searchWord)) {
          result.add(item);
        }
      }
    }
    return result;
  }

  void selectCategory(Category? category) {
    selectedCategory = category;
    items = _filter();
    notifyListeners();
  }

  void updateSearchWord(String value) {
    searchWord = value;
    items = _filter();
    notifyListeners();
  }
}
