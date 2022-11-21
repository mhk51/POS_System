class Item {
  final String barcode;
  final String name;
  final int price;

  Item({required this.barcode, required this.name, required this.price});

  Map<String, dynamic> toMap() {
    return {
      "barcode": barcode,
      "name": name,
      "price": price,
    };
  }

  @override
  String toString() {
    return 'Item{barcode: $barcode, name: $name, price: $price}';
  }
}
