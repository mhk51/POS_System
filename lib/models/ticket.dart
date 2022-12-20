import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ticket extends ChangeNotifier {
  int itemCount;
  int totalCost;
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

  Future<Map<String, dynamic>> toMap() async {
    final prefs = await SharedPreferences.getInstance();
    int current = prefs.getInt('ticketID') ?? 0;
    String ticketNumber = '#1-1${NumberFormat('000').format(current + 1)}';
    await prefs.setInt('ticketID', current + 1);
    return {
      "ticketNumber": ticketNumber,
      "totalCost": totalCost,
      "itemCount": itemCount,
      "items": items.map(
        (item, qty) {
          Map<String, dynamic> data = item.toMap();
          data.addAll({'qty': qty});
          return MapEntry(item.name, data);
        },
      ),
      "time": DateTime.now(),
    };
  }
}
