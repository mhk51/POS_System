import 'package:flutter/material.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/ticket.dart';
import 'package:intl/intl.dart';

class CustomSearchDelegate extends SearchDelegate {
  Ticket ticket;
  final List<Item> items;
  CustomSearchDelegate({required this.items, required this.ticket});

  Widget tilefromItem(Item item) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () => ticket.addItem(item),
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
          item.name,
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

  List<String?> categories = [null, "Condiments", "Snacks"];

  DropdownMenuItem<String?> dropDownFromString(String? value) {
    return DropdownMenuItem<String?>(
      value: value,
      child: Text(value ?? "No Category"),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      DropdownButtonHideUnderline(
        child: DropdownButton(
            items: categories.map(dropDownFromString).toList(),
            onChanged: (value) {}),
      ),
      IconButton(
        onPressed: () {
          if (query == '') {
            Navigator.pop(context);
          }
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
      if (item.name.toLowerCase().startsWith(query.toLowerCase())) {
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
      if (item.name.toLowerCase().startsWith(query.toLowerCase())) {
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
