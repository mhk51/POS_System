import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/ticket.dart';
import 'package:scanner_app/pages/sales_page/sales_item_tile.dart';
import 'package:scanner_app/pages/sales_page/sales_item_grid.dart';

class SalesItemsList extends StatelessWidget {
  const SalesItemsList({super.key});

  List<Item> filterSearchResults(String query, Category? category, List<Item> items) {
    List<Item> returnList = [];
    for (Item item in items) {
      if (item.name!.startsWith(query)) {
        if (category == null) {
          returnList.add(item);
        } else if (item.category != null && category.name == item.category!.name) {
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
    List<Item> ticketItems = ticket.items.keys.toList();
    List<Item> filteredItems = filterSearchResults(ticket.searchWord, ticket.category, items);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 400,
        child: ticket.searchMode
            ? ListView.separated(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return SalesItemTile(item: filteredItems[index]);
                },
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(left: 70.0),
                    child: Divider(thickness: 1),
                  );
                },
              )
            : SalesItemGrid(),
        // : ListView(
        //     children: List<Widget>.generate(ticket.items.length, (index) {
        //       Item ticketItem = ticketItems[index];
        //       int qty = ticket.items[ticketItem]!;
        //       return TicketItemTile(item: ticketItem, qty: qty);
        //     }),
        //   ),
      ),
    );
  }
}

class TicketItemTile extends StatefulWidget {
  final int qty;
  final Item item;
  const TicketItemTile({super.key, required this.item, required this.qty});

  @override
  State<TicketItemTile> createState() => _TicketItemTileState();
}

class _TicketItemTileState extends State<TicketItemTile> {
  int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.item.name!),
      leading: SizedBox(
        height: double.infinity,
        width: 60,
        child: widget.item.image == null
            ? Icon(
                widget.item.shape,
                color: widget.item.color,
                size: 50,
              )
            : CircleAvatar(
                backgroundImage: FileImage(widget.item.image!),
                radius: 25,
              ),
      ),
      trailing: Column(
        children: [
          Text('as3r'),
          Container(
            width: 60,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Theme.of(context).primaryColor),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      if (_itemCount > 0) {
                        setState(() {
                          _itemCount--;
                        });
                      }
                    },
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 16,
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white),
                  child: Text(
                    _itemCount.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _itemCount++;
                    });
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
