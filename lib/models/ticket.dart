import 'package:flutter/cupertino.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';

class Ticket extends ChangeNotifier {
  int itemCount;
  int totalCost;
  int totalPrice;
  String searchWord;
  Category? category;

  Map<Item, int> items = {};

  Ticket({
    this.itemCount = 0,
    this.totalCost = 0,
    this.searchWord = "",
    this.totalPrice = 0,
  });

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
    totalPrice += item.price;
    if (item.cost != null) {
      totalCost += item.cost!;
    }
    notifyListeners();
  }

  void incrementItem(Item item) {
    items[item] = items[item]! + 1;
    itemCount++;
    totalPrice += item.price;
    if (item.cost != null) {
      totalCost += item.cost!;
    }
    notifyListeners();
  }

  void decrementItem(Item item) {
    if (items[item]! > 1) {
      items[item] = items[item]! - 1;
      itemCount--;
      totalPrice -= item.price;
      if (item.cost != null) {
        totalCost -= item.cost!;
      }
      notifyListeners();
    }
  }

  void setItemQuantity(Item item, int qty) {
    int oldQty = items[item]!;
    items[item] = qty;
    itemCount += qty - oldQty;
    totalPrice += (qty - oldQty) * item.price;
    if (item.cost != null) {
      totalCost += (qty - oldQty) * item.cost!;
    }
    notifyListeners();
  }

  void removeItem(Item item) {
    int qty = items[item]!;
    items.remove(item);
    itemCount -= qty;
    totalPrice -= (item.price * qty);
    if (item.cost != null) {
      totalCost -= (item.cost! * qty);
    }
    notifyListeners();
  }
}
