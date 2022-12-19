import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/drawer/drawer.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/item_list.dart';
import 'package:scanner_app/pages/items_page/items_appbar.dart';
import 'package:scanner_app/pages/items_page/items_list.dart';
import 'package:scanner_app/shared/routes.dart';
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

  void refresh() {
    setState(() {});
  }

  String searchString = '';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ItemList(),
        ),
      ],
      builder: (context, snapshot) {
        ItemList itemList = Provider.of(context);
        List<Item> items = itemList.items;
        if (!itemList.loading) {
          return Scaffold(
            drawer: const NavDrawer(),
            appBar: const ItemsAppBar(),
            body: ItemsList(
              items: items,
              refresh: refresh,
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () async {
                Item? item =
                    await Navigator.pushNamed(context, PageRoutes.addItem)
                        as Item?;
                if (item != null) {
                  await ItemServices.insertItem(item);
                }
                await itemList.load();
              },
              child: const Icon(
                Icons.add,
              ),
            ),
          );
        } else {
          return Loading(backGroundColor: Theme.of(context).primaryColor);
        }
      },
    );
  }
}
