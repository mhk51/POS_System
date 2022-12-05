import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/drawer/drawer.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/search_class.dart';
import 'package:scanner_app/pages/items_page/category_dropdown.dart';
import 'package:scanner_app/pages/items_page/item_tile.dart';
import 'package:scanner_app/pages/items_page/items_appbar.dart';
import 'package:scanner_app/pages/items_page/items_list.dart';
import 'package:scanner_app/pages/routes.dart';
import 'package:scanner_app/services/categories_services.dart';
import 'package:scanner_app/shared/loading.dart';
import 'package:scanner_app/services/items_services.dart';

class ItemsPage extends StatefulWidget {
  static const String routeName = '/home';
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  List<Category?> getCategoriesFromItems(List<Item> items) {
    Set<Category?> set = {};
    for (var element in items) {
      set.add(element.category);
    }
    return set.toList();
  }

  Category? selectedCategory;

  void onChanged(Category? category) {
    setState(() {
      selectedCategory = category;
    });
  }

  Future<Map<String, dynamic>> getInfo() async {
    List<Future> futures = [
      CategoriesServices.getAllCategories(),
      ItemServices.getAllItems(categoryName: selectedCategory?.name),
    ];

    List reponses = await Future.wait(futures);
    List<Category?> categories = reponses[0];
    List<Item> items = reponses[1];

    return {"categories": categories, "items": items};
  }

  String searchString = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: getInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError) {
            List<Category?> categories = snapshot.data!['categories'];
            List<Item> items = snapshot.data!['items'];
            return MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(
                    value: SearchClass(),
                  ),
                ],
                builder: (context, snapshot) {
                  return Scaffold(
                    drawer: const NavDrawer(),
                    appBar: ItemsAppBar(
                      onChanged: onChanged,
                      categories: categories,
                      selectedCategory: selectedCategory,
                    ),
                    body: ItemsList(items: items),
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      onPressed: () async {
                        Item? item = await Navigator.pushNamed(
                            context, PageRoutes.addItem) as Item?;
                        if (item != null) {
                          await ItemServices.insertItem(item);
                        }
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.add,
                      ),
                    ),
                  );
                });
          } else {
            return Loading(backGroundColor: Theme.of(context).primaryColor);
          }
        });
  }
}
