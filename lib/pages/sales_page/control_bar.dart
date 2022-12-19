import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/item_builder.dart';
import 'package:scanner_app/models/ticket.dart';
import 'package:scanner_app/pages/sales_page/search_delegate.dart';
import 'package:scanner_app/services/items_services.dart';
import 'package:scanner_app/shared/routes.dart';

class ControlBar extends StatefulWidget {
  const ControlBar({super.key});

  @override
  State<ControlBar> createState() => _ControlBarState();
}

class _ControlBarState extends State<ControlBar> {
  @override
  Widget build(BuildContext context) {
    List<Item> items = Provider.of(context);
    Ticket ticket = Provider.of(context);
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            onTap: () async {
              await showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(items: items, ticket: ticket));
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            tileColor: Colors.white,
            leading: const Icon(
              Icons.search,
              size: 28,
            ),
            title: Text(
              'Search',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            trailing: IconButton(
              iconSize: 30,
              icon: const Icon(CupertinoIcons.barcode_viewfinder),
              onPressed: () async {
                String barcode;
                try {
                  barcode = await FlutterBarcodeScanner.scanBarcode(
                      '#ff6666', 'Cancel', true, ScanMode.BARCODE);
                } on PlatformException {
                  barcode = 'Failed to get platform version.';
                }
                if (barcode == '-1') {
                  return;
                }
                if (!mounted) return;
                List<Item> items = Provider.of(context, listen: false);
                Item? item;
                for (Item elem in items) {
                  if (barcode == elem.barcode) {
                    item = elem;
                    break;
                  }
                }
                if (item != null) {
                  ticket.addItem(item);
                } else {
                  bool? result = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                            'Item not found, would you like to add it?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text('No')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text('Yes'))
                        ],
                      );
                    },
                  );
                  if (result != null && result && mounted) {
                    Item? item = await Navigator.pushNamed(
                        context, PageRoutes.addItem,
                        arguments: ItemBuilder(barcode: barcode)) as Item?;
                    if (item != null) {
                      await ItemServices.insertItem(item);
                      ticket.addItem(item);
                    }
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
