import 'package:flutter/cupertino.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';

class Ticket extends ChangeNotifier {
  int itemCount;
  int totalCost;
  List<Item> items = [];
  List<int> itemQty = [];
  String searchWord;
  Category? category;
  bool searchMode = false;

  Ticket({this.itemCount = 0, this.totalCost = 0, this.searchWord = ""});

  void clear() {
    itemCount = 0;
    totalCost = 0;
    items = [];
    notifyListeners();
  }

  void updateSearchWord(String searchWord) {
    this.searchWord = searchWord;
    notifyListeners();
  }

  void updateCategory(Category? category) {
    this.category = category;
    notifyListeners();
  }

  void updateSearchMode(bool searchMode) {
    this.searchMode = searchMode;
    notifyListeners();
  }

  void addItem(Item item) {
    items.add(item);
    itemCount++;
    totalCost += item.price!;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {"totalCost": totalCost, "items": items.map((e) => e.name).toList()};
  }
}
