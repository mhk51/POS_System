import "package:flutter/material.dart";
import 'package:scanner_app/models/category.dart';

// ignore: must_be_immutable
class FilterDropDown extends StatefulWidget {
  final Function(Category? category) onChanged;
  List<Category?> categories;
  Category? selectedValue;
  FilterDropDown(
      {super.key,
      required this.onChanged,
      required this.categories,
      required this.selectedValue});

  @override
  State<FilterDropDown> createState() => _FilterDropDownState();
}

class _FilterDropDownState extends State<FilterDropDown> {
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

  Container representionFromCategory(Category? category) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        category != null ? category.name : "No Category",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Category?> list = List.from(widget.categories);
    list.add(null);
    List<DropdownMenuItem<Category?>> categoriesDropDown =
        list.map(dropDownfromCategory).toList();
    return DropdownButton<Category?>(
      isExpanded: false,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      value: widget.selectedValue,
      items: categoriesDropDown,
      onChanged: widget.onChanged,
      selectedItemBuilder: (context) {
        return list.map(representionFromCategory).toList();
      },
    );
  }
}
