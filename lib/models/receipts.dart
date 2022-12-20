import 'package:scanner_app/models/item.dart';

class Receipt {
  int itemCount;
  int totalCost;
  DateTime time;
  Map<Item, int> items;
  String receciptNumber;
  Receipt({
    required this.itemCount,
    required this.items,
    required this.totalCost,
    required this.time,
    required this.receciptNumber,
  });
}
