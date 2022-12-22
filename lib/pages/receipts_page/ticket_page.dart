import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/item_qty.dart';
import 'package:scanner_app/models/receipts.dart';
import 'package:scanner_app/objectbox.g.dart';
import 'package:scanner_app/services/settings_services.dart';

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
    bool showProfit = SettingsServices.getSettings().showPrice;
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
              '${NumberFormat('###,###.##').format(showProfit ? receipt.totalPrice - receipt.totalCost : receipt.totalPrice)} L.L',
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
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            subtitle: const Text('Cost'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${NumberFormat('###,###.##').format(receipt.totalPrice)} L.L',
                ),
                Text(
                  '${NumberFormat('- ###,###.##').format(receipt.totalCost)} L.L',
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            endIndent: 20,
            indent: 290,
            height: 0,
          ),
          ListTile(
            title: const Text(
              'Profit',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            trailing: Text(
              '${NumberFormat('###,###.##').format(receipt.totalPrice - receipt.totalCost)} L.L',
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
          ),
        ],
      ),
    );
  }
}
