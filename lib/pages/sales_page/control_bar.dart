import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/ticket.dart';
import 'package:scanner_app/pages/items_page/item_tile.dart';
import 'package:scanner_app/pages/sales_page/sales_item_tile.dart';

class ControlBar extends StatefulWidget {
  const ControlBar({super.key});

  @override
  State<ControlBar> createState() => _ControlBarState();
}

class _ControlBarState extends State<ControlBar> {
  DropdownMenuItem<Category?> dropDownfromCategory(Category? category) {
    return DropdownMenuItem<Category?>(
      value: category,
      child: Text(
        category != null ? category.name : "No Category",
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  bool _searchBool = false;

  @override
  Widget build(BuildContext context) {
    List<Category?> categories = Provider.of(context);
    List<Item> items = Provider.of(context);
    Ticket ticket = Provider.of(context);
    return SizedBox(
      height: 70,
      child: _searchBool
          ? TextField(
              onChanged: (value) {
                ticket.updateSearchWord(value);
              },
              autofocus: true,
              cursorColor: Colors.black,
              style: const TextStyle(fontSize: 24),
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    style: BorderStyle.none,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    style: BorderStyle.none,
                  ),
                ),
                contentPadding: const EdgeInsets.all(10),
                suffix: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _searchBool = false;
                    });
                    ticket.updateSearchMode(false);
                  },
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        items: categories.map(dropDownfromCategory).toList(),
                        onChanged: (value) {
                          ticket.updateCategory(value);
                        },
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(width: 0, thickness: 1),
                Expanded(
                  flex: 1,
                  child: IconButton(
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
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog();
                          },
                        );
                      }
                    },
                    icon: const Icon(
                      CupertinoIcons.barcode_viewfinder,
                      size: 30,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(items: items),
                      );
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<Item> items;
  CustomSearchDelegate({required this.items});

  Widget tilefromItem(Item item) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () async {},
        leading: SizedBox(
          height: double.infinity,
          width: 60,
          child: item.image == null
              ? Icon(
                  item.shape,
                  color: item.color,
                  size: 40,
                )
              : CircleAvatar(
                  backgroundImage: FileImage(item.image!),
                  radius: 20,
                ),
        ),
        title: Text(
          item.name!,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        trailing: Text(
          '${NumberFormat('###,###.##').format(item.price)} L.L',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Item> matchQuery = [];
    for (Item item in items) {
      if (item.name!.toLowerCase().startsWith(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView(
      children: matchQuery.map(tilefromItem).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Item> matchQuery = [];
    for (Item item in items) {
      if (item.name!.toLowerCase().startsWith(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView(
        children: matchQuery.map(tilefromItem).toList(),
      ),
    );
  }
}
