import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/item_builder.dart';
import 'package:scanner_app/models/search_class.dart';
import 'package:scanner_app/pages/items_page/category_dropdown.dart';
import 'package:scanner_app/shared/routes.dart';
import 'package:scanner_app/services/items_services.dart';

// ignore: must_be_immutable
class ItemsAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(Category?) onChanged;
  final List<Category?> categories;
  Category? selectedCategory;
  ItemsAppBar(
      {super.key,
      required this.selectedCategory,
      required this.categories,
      required this.onChanged});

  @override
  State<ItemsAppBar> createState() => _ItemsAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ItemsAppBarState extends State<ItemsAppBar> {
  bool _searchBool = false;
  @override
  Widget build(BuildContext context) {
    SearchClass searchClass = Provider.of<SearchClass>(context);
    return AppBar(
      leading: _searchBool
          ? IconButton(
              onPressed: () {
                setState(() {
                  _searchBool = false;
                });
              },
              icon: const Icon(Icons.arrow_back),
            )
          : null,
      title: _searchBool
          ? TextField(
              autofocus: true,
              onChanged: (value) {
                searchClass.updateSearchWord(value);
              },
              decoration: const InputDecoration(
                  hintText: "Search",
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
              cursorColor: Colors.white,
            )
          : FilterDropDown(
              selectedValue: widget.selectedCategory,
              categories: widget.categories,
              onChanged: widget.onChanged,
            ),
      backgroundColor: Theme.of(context).primaryColor,
      actions: _searchBool
          ? []
          : [
              IconButton(
                style: IconButton.styleFrom(padding: EdgeInsets.zero),
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
                  Item? item = await ItemServices.getItem(barcode);
                  ItemBuilder? itemBuilder;
                  if (item != null) {
                    itemBuilder = ItemBuilder.fromItem(item);
                  }
                  itemBuilder ??= ItemBuilder(barcode: null);
                  if (!mounted) return;
                  Item? updatedItem = await Navigator.pushNamed(
                      context, PageRoutes.addItem,
                      arguments: item) as Item?;
                  if (updatedItem != null) {
                    await ItemServices.insertItem(updatedItem);
                  }
                  setState(() {});
                },
                icon: const Icon(
                  CupertinoIcons.barcode_viewfinder,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              IconButton(
                style: IconButton.styleFrom(padding: EdgeInsets.zero),
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    _searchBool = true;
                  });
                },
              )
            ],
    );
  }
}
