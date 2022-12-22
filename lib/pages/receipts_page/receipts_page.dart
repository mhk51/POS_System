import 'package:flutter/material.dart';
import 'package:scanner_app/drawer/drawer.dart';
import 'package:scanner_app/models/receipts.dart';
import 'package:scanner_app/pages/receipts_page/group_seperator.dart';
import 'package:scanner_app/pages/receipts_page/receipt_tile.dart';
import 'package:scanner_app/services/receipt_services.dart';
import 'package:scanner_app/shared/loading.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class ReceiptsPage extends StatefulWidget {
  static const String routeName = '/receipts';
  const ReceiptsPage({super.key});

  @override
  State<ReceiptsPage> createState() => _ReceiptsPageState();
}

class _ReceiptsPageState extends State<ReceiptsPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Receipt>>(
        stream: ReceiptServices.getReceipts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              !snapshot.hasError) {
            List<Receipt> receipts = snapshot.data!;
            return Scaffold(
              drawer: const NavDrawer(),
              appBar: AppBar(
                title: const Text('Receipts Page'),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              body: Column(
                children: [
                  const SizedBox(height: 5),
                  TextFormField(
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      focusColor: Theme.of(context).primaryColor,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey[500],
                      ),
                      prefixIconColor: Theme.of(context).primaryColor,
                      hintText: "Search",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[200]!),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                  ),
                  receipts.isNotEmpty
                      ? Expanded(
                          child: StickyGroupedListView<Receipt, DateTime>(
                            separator: const Padding(
                              padding: EdgeInsets.only(left: 70.0),
                              child: Divider(height: 0),
                            ),
                            padding: EdgeInsets.zero,
                            elements: receipts,
                            groupBy: (Receipt element) => DateTime(
                              element.time.year,
                              element.time.month,
                              element.time.day,
                            ),
                            groupComparator: (value1, value2) =>
                                value2.compareTo(value1),
                            itemComparator: (element1, element2) =>
                                element2.time.compareTo(element1.time),
                            groupSeparatorBuilder: (Receipt receipt) {
                              return GroupSeperator(receipt: receipt);
                            },
                            itemBuilder: (context, Receipt receipt) {
                              return ReceiptTile(receipt: receipt);
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          } else {
            return Loading(backGroundColor: Theme.of(context).primaryColor);
          }
        });
  }
}
