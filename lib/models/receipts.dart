import 'package:scanner_app/models/item_qty.dart';
import 'package:scanner_app/models/ticket.dart';
import 'package:scanner_app/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Receipt {
  @Id()
  int? id;

  final int itemCount;
  final int totalCost;
  final int totalPrice;
  final DateTime time;

  final ToMany<ItemQty> items;
  Receipt({
    required this.itemCount,
    required this.totalCost,
    required this.totalPrice,
    required this.time,
    this.id,
    required this.items,
  });

  factory Receipt.fromTicket(Ticket ticket) {
    List<ItemQty> items = [];
    for (MapEntry mapEntry in ticket.items.entries) {
      items
          .add(ItemQty(qty: mapEntry.value, item: ToOne(target: mapEntry.key)));
    }
    return Receipt(
      items: ToMany<ItemQty>(items: items),
      totalPrice: ticket.totalPrice,
      itemCount: ticket.itemCount,
      totalCost: ticket.totalCost,
      time: DateTime.now(),
    );
  }
}
