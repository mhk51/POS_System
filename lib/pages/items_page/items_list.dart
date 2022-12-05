import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/search_class.dart';
import 'package:scanner_app/pages/items_page/item_tile.dart';

class ItemsList extends StatefulWidget {
  final List<Item> items;
  const ItemsList({super.key, required this.items});

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  List<Item> filterSearchResults(String query, List<Item> items) {
    List<Item> returnList = [];
    for (Item item in items) {
      if (item.name!.startsWith(query)) {
        returnList.add(item);
      }
    }
    return returnList;
  }

  @override
  Widget build(BuildContext context) {
    SearchClass searchClass = Provider.of<SearchClass>(context);
    List<Item> items =
        filterSearchResults(searchClass.searchWord, widget.items);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ItemTile(
            item: items[index],
            callBack: () {
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
