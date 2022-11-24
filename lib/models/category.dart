class Category {
  int? id;
  final String name;
  final int color;
  int items;

  Category({
    required this.name,
    required this.color,
    required this.items,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      'color': color,
      'items': items,
    };
  }

  @override
  String toString() {
    return 'Category{name: $name, color: $color, items: $items}';
  }
}
