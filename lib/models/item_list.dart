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

  void load() {
    loading = true;
    notifyListeners();

    categories = CategoriesServices.getAllCategories();
    _allItems = ItemServices.getAllItems(categoryID: selectedCategory?.id);
    items = _filter();

    loading = false;
    notifyListeners();
  }

  List<Item> _filter() {
    List<Item> result = [];
    for (Item item in _allItems) {
      if (selectedCategory == null ||
          item.category.target == selectedCategory) {
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
