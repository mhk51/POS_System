import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/ticket.dart';

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
                      List<Item> items = Provider.of(context);
                      Item? item;
                      for (Item elem in items) {
                        if (barcode == elem.barcode) {
                          item = elem;
                          break;
                        }
                      }
                      if (item != null) {
                        ticket.addItem(item);
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
                      setState(() {
                        _searchBool = true;
                      });
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
