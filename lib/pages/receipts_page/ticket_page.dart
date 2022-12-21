import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/item_qty.dart';
import 'package:scanner_app/models/receipts.dart';
import 'package:scanner_app/objectbox.g.dart';

class TicketPage extends StatelessWidget {
  static const String routeName = "/ticket_page";
  const TicketPage({super.key});

  List<Widget> itemTiles(ToMany<ItemQty> data) {
    List<Widget> tiles = [];
    for (ItemQty entry in data.toList()) {
      Item item = entry.item.target!;
      int qty = entry.qty;
      tiles.add(
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: Text(item.name),
          subtitle: Text(
              '$qty x ${NumberFormat('###,###.##').format(item.price)} L.L'),
          trailing: Text(
              '${NumberFormat('###,###.##').format(item.price * qty)} L.L'),
        ),
      );
      tiles.add(const Divider(
        thickness: 1,
        endIndent: 20,
        indent: 20,
      ));
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    Receipt receipt = ModalRoute.of(context)!.settings.arguments as Receipt;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('#1-1${NumberFormat('000').format(receipt.id)}'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Center(
            child: Text(
              '${NumberFormat('###,###.##').format(receipt.totalCost)} L.L',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Total',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(
            thickness: 1,
            endIndent: 20,
            indent: 20,
          ),
          ...itemTiles(receipt.items),
          ListTile(
            title: const Text(
              'Total',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: const Text('Cash'),
            trailing: Text(
              '${NumberFormat('###,###.##').format(receipt.totalCost)} L.L',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(
            thickness: 1,
            endIndent: 20,
            indent: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${DateFormat.yMd().format(receipt.time)} ${DateFormat.jm().format(receipt.time)}',
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  '#1-1${NumberFormat('000').format(receipt.id)}',
                  style: const TextStyle(color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
