import 'package:flutter/cupertino.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';

class Ticket extends ChangeNotifier {
  int itemCount;
  int totalCost;
  List<int> itemQty = [];
  String searchWord;
  Category? category;

  Map<Item, int> items = {};

  Ticket({this.itemCount = 0, this.totalCost = 0, this.searchWord = ""});

  void clear() {
    itemCount = 0;
    totalCost = 0;
    items = {};
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

  void addItem(Item item) {
    if (items.containsKey(item)) {
      items[item] = items[item]! + 1;
    } else {
      items[item] = 1;
    }
    itemCount++;
    totalCost += item.price;
    notifyListeners();
  }

  void incrementItem(Item item) {
    items[item] = items[item]! + 1;
    itemCount++;
    totalCost += item.price;
    notifyListeners();
  }

  void decrementItem(Item item) {
    if (items[item]! > 1) {
      items[item] = items[item]! - 1;
      itemCount--;
      totalCost -= item.price;
      notifyListeners();
    }
  }

  void setItemQuantity(Item item, int qty) {
    int oldQty = items[item]!;
    items[item] = qty;
    itemCount += qty - oldQty;
    totalCost += (qty - oldQty) * item.price;
    notifyListeners();
  }

  void removeItem(Item item) {
    int qty = items[item]!;
    items.remove(item);
    itemCount -= qty;
    totalCost -= (item.price * qty);
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      "totalCost": totalCost,
      "items": items.map(
        (item, qty) {
          Map<String, dynamic> data = item.toMap();
          data.addAll({'qty': qty});
          return MapEntry(item.name, data);
        },
      ),
    };
  }
}
