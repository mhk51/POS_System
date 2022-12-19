import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item_list.dart';

// ignore: must_be_immutable
class FilterDropDown extends StatefulWidget {
  const FilterDropDown({
    super.key,
  });

  @override
  State<FilterDropDown> createState() => _FilterDropDownState();
}

class _FilterDropDownState extends State<FilterDropDown> {
  DropdownMenuItem<Category?> dropDownfromCategory(Category? category) {
    return DropdownMenuItem<Category?>(
      value: category,
      child: Text(
        category != null ? category.name : "All Categories",
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  Container representionFromCategory(Category? category) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        category != null ? category.name : "All Categories",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ItemList itemList = Provider.of(context);
    List<Category?> list = List.from(itemList.categories);
    list.add(null);
    List<DropdownMenuItem<Category?>> categoriesDropDown =
        list.map(dropDownfromCategory).toList();
    return DropdownButtonHideUnderline(
      child: DropdownButton<Category?>(
        isExpanded: false,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        value: itemList.selectedCategory,
        items: categoriesDropDown,
        onChanged: (value) => itemList.selectCategory(value),
        selectedItemBuilder: (context) {
          return list.map(representionFromCategory).toList();
        },
      ),
    );
  }
}
