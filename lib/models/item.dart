// ignore_for_file: constant_identifier_names

enum Currency { USD, LPB }

class Item {
  final String barcode;
  final String name;
  final double price;
  final Currency currency;
  double? cost;
  int? colorValue;

  Item({
    required this.barcode,
    required this.name,
    required this.price,
    required this.currency,
    this.cost,
    this.colorValue,
  });

  Map<String, dynamic> toMap() {
    return {
      "barcode": barcode,
      "name": name,
      "price": price,
      'colorValue': colorValue,
    };
  }

  @override
  String toString() {
    return 'Item{barcode: $barcode, name: $name, price: $price, color: $colorValue}';
  }
}
