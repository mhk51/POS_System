import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/ticket.dart';
import 'package:scanner_app/pages/sales_page/sales_item_tile.dart';

class SalesItemsList extends StatelessWidget {
  const SalesItemsList({super.key});

  List<Item> filterSearchResults(
      String query, Category? category, List<Item> items) {
    List<Item> returnList = [];
    for (Item item in items) {
      if (item.name!.startsWith(query)) {
        if (category == null) {
          returnList.add(item);
        } else if (item.category != null &&
            category.name == item.category!.name) {
          returnList.add(item);
        }
      }
    }
    return returnList;
  }

  @override
  Widget build(BuildContext context) {
    List<Item> items = Provider.of(context);
    Ticket ticket = Provider.of(context);
    List<Item> filteredItems =
        filterSearchResults(ticket.searchWord, ticket.category, items);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 400,
        child: ListView.separated(
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            return SalesItemTile(item: filteredItems[index]);
          },
          separatorBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.only(left: 70.0),
              child: Divider(
                thickness: 1,
              ),
            );
          },
        ),
      ),
    );
  }
}
