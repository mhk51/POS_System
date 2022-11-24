import 'package:flutter/material.dart';
import 'package:scanner_app/models/category.dart';

class AddCategory extends StatefulWidget {
  static const String routeName = '/add_category';
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Color> upperColors = [
    Colors.grey,
    Colors.red,
    Colors.pink,
    Colors.orange,
  ];
  List<Color> lowerColors = [
    Colors.lightGreen,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];
  Color selectedColor = Colors.grey;
  String categoryName = '';
  Category? categoryArg;
  int? categoryId;

  ElevatedButton textButtonFromColor(Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
      ),
      onPressed: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: SizedBox(
        height: 70,
        width: 40,
        child: selectedColor.value == color.value
            ? const Icon(
                Icons.check,
                size: 30,
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Category? data = ModalRoute.of(context)!.settings.arguments as Category?;
    if (data != null && categoryArg == null) {
      categoryArg = data;
      categoryId = categoryArg!.id;
      categoryName = categoryArg!.name;
      selectedColor = Color(categoryArg!.color);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: TextButton(
              onPressed: () {
                Category category = Category(
                    id: categoryId,
                    color: selectedColor.value,
                    name: categoryName,
                    items: 0);
                Navigator.pop(context, category);
              },
              child: const Text(
                'SAVE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: TextFormField(
                  initialValue: categoryName,
                  onChanged: (value) {
                    categoryName = value;
                  },
                  validator: (value) {
                    return value!.isNotEmpty ? null : "Please Enter a Name";
                  },
                  decoration: const InputDecoration(hintText: 'Category Name'),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: upperColors.map(textButtonFromColor).toList(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: lowerColors.map(textButtonFromColor).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
