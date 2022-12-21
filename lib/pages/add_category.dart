import 'package:flutter/material.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/shared/select_color.dart';
import 'package:scanner_app/services/categories_services.dart';

class AddCategory extends StatefulWidget {
  static const String routeName = '/add_category';
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Color selectedColor = Colors.grey;
  String categoryName = '';
  Category? categoryArg;
  int? categoryID;

  FocusNode myFocusNode = FocusNode();

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(myFocusNode);
    });
  }

  void setSelectedColor(Color color) {
    selectedColor = color;
  }

  @override
  Widget build(BuildContext context) {
    Category? data = ModalRoute.of(context)!.settings.arguments as Category?;
    if (data != null && categoryArg == null) {
      categoryArg = data;
      categoryName = data.name;
      categoryID = data.id;
      selectedColor = Color(data.color);
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
                  selectedColor.value,
                  name: categoryName,
                  id: categoryID,
                );
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: TextFormField(
                              onTap: _requestFocus,
                              focusNode: myFocusNode,
                              initialValue: categoryName,
                              onChanged: (value) {
                                categoryName = value;
                              },
                              validator: (value) {
                                return value!.isNotEmpty
                                    ? null
                                    : "Please Enter a Name";
                              },
                              decoration: InputDecoration(
                                labelText: 'Category Name',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                focusColor: Theme.of(context).primaryColor,
                                labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Theme.of(context).primaryColor
                                      : null,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Category Color',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          const SizedBox(height: 20),
                          SelectColor(
                            setSelectedColor: setSelectedColor,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: BorderSide(
                            width: 1.5,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        child: Text(
                          'ASSIGN ITEMS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: BorderSide(
                            width: 1.5,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        child: Text(
                          'CREATE ITEM',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              data == null
                  ? Container()
                  : Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                2.0, 2.0), // shadow direction: bottom right
                          ),
                        ],
                      ),
                      child: TextButton.icon(
                        onPressed: () {
                          CategoriesServices.deleteCategory(data);
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey[600],
                        ),
                        label: Text(
                          'DELETE CATEGORY',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
