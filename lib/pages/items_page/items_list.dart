import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/item_list.dart';
import 'package:scanner_app/pages/items_page/item_tile.dart';

class ItemsList extends StatefulWidget {
  const ItemsList({
    super.key,
  });

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  Widget build(BuildContext context) {
    List<Item> items = Provider.of<ItemList>(context).items;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ItemTile(
            item: items[index],
          );
        },
      ),
    );
  }
}
