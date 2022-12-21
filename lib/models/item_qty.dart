import 'package:objectbox/objectbox.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/objectbox.g.dart';

@Entity()
class ItemQty {
  @Id()
  int? id;
  final ToOne<Item> item;
  int qty;

  ItemQty({required this.qty, required this.item});
}
