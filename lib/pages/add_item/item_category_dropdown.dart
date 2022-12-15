import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item_builder.dart';

class CategoryDropDown extends StatefulWidget {
  final List<Category> categories;
  const CategoryDropDown({super.key, required this.categories});

  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  Category? dropdownValue;

  @override
  Widget build(BuildContext context) {
    ItemBuilder item = Provider.of<ItemBuilder>(context);
    dropdownValue = item.category;
    DropdownMenuItem<Category?> dropDownMenuItem = DropdownMenuItem<Category?>(
      value: null,
      child: const Text('No category'),
      onTap: () => item.updateCategory(null),
    );
    List<DropdownMenuItem<Category?>> categoriesDropDown = [dropDownMenuItem];
    categoriesDropDown.addAll(
        widget.categories.map<DropdownMenuItem<Category>>((Category value) {
      return DropdownMenuItem<Category>(
        value: value,
        child: Text(value.name),
        onTap: () => item.updateCategory(value),
      );
    }).toList());
    return DropdownButtonFormField<Category?>(
      borderRadius: BorderRadius.circular(9),
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      onChanged: (Category? value) {
        setState(() {
          dropdownValue = value;
        });
      },
      items: categoriesDropDown,
    );
  }
}
