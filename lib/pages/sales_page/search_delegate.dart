import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/ticket.dart';
import 'package:intl/intl.dart';
import 'package:scanner_app/services/categories_services.dart';

class CustomSearchDelegate extends SearchDelegate {
  Ticket ticket;
  final List<Item> items;
  CustomSearchDelegate({required this.items, required this.ticket});
  Category? selectedCategory;
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
                  IconData(item.shape, fontFamily: "MaterialIcons"),
                  color: Color(item.color),
                  size: 40,
                )
              : CircleAvatar(
                  backgroundImage: FileImage(File(item.image!)),
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

  List<Category?> categories = [null, ...CategoriesServices.getAllCategories()];

  DropdownMenuItem<Category?> dropDownFromString(Category? value) {
    return DropdownMenuItem<Category?>(
      value: value,
      child: Text(value?.name ?? "All Categories"),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      DropdownButtonHideUnderline(
        child: DropdownButton(
            value: selectedCategory,
            items: categories.map(dropDownFromString).toList(),
            onChanged: (value) {
              selectedCategory = value;
              showResults(context);
              showSuggestions(context);
            }),
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
        if (selectedCategory == item.category.target ||
            selectedCategory == null) {
          matchQuery.add(item);
        }
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
        if (selectedCategory == item.category.target ||
            selectedCategory == null) {
          matchQuery.add(item);
        }
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
