import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/item_builder.dart';
import 'package:scanner_app/pages/add_item/delete_item.dart';
import 'package:scanner_app/pages/add_item/item_representation.dart';
import 'package:scanner_app/pages/add_item/stock_container.dart';
import 'package:scanner_app/services/categories_services.dart';
import 'package:scanner_app/services/items_services.dart';
import 'package:scanner_app/shared/loading.dart';

import 'item_details_container.dart';

class AddItem extends StatefulWidget {
  static const String routeName = '/add_item';
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  Future<Map<String, dynamic>> getItemData() async {
    ItemBuilder? data =
        ModalRoute.of(context)!.settings.arguments as ItemBuilder?;
    List<Future> futures = [
      CategoriesServices.getAllCategories(),
    ];
    if (data != null && data.barcode != null) {
      futures.add(ItemServices.getItem(data.barcode!));
    }
    List reponses = await Future.wait(futures);
    List<Category> categories = reponses[0];
    ItemBuilder? itemResponse;
    Item? item = reponses[1];
    if (data != null && data.barcode != null) {
      itemResponse = item != null
          ? ItemBuilder.fromItem(item)
          : ItemBuilder(barcode: data.barcode);
    }

    return {"categories": categories, "item": itemResponse};
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: getItemData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> map = snapshot.data!;
            List<Category> categories = map['categories'];
            ItemBuilder? itemArg = map['item'];
            return MultiProvider(
              providers: [
                ChangeNotifierProvider.value(
                  value: itemArg ?? ItemBuilder(),
                ),
              ],
              builder: (context, snapshot) {
                ItemBuilder itemBuilder = Provider.of<ItemBuilder>(context);
                return Scaffold(
                  appBar: AppBar(
                    title: Text(itemArg == null ? "Add Item" : "Edit Item"),
                    backgroundColor: Theme.of(context).primaryColor,
                    actions: [
                      TextButton(
                        onPressed: () {
                          itemBuilder.update();
                          if (_key.currentState!.validate()) {
                            Navigator.pop(
                                context, Item.fromBuilder(itemBuilder));
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
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
                      child: Form(
                        key: _key,
                        child: Column(
                          children: [
                            ItemDetailsContainer(
                              categories: categories,
                            ),
                            const SizedBox(height: 20),
                            const StockContainer(),
                            const SizedBox(height: 20),
                            const ItemRepresentation(),
                            const SizedBox(height: 20),
                            itemArg != null ? const DeleteItem() : Container(),
                            const SizedBox(height: 10)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Loading(backGroundColor: Theme.of(context).primaryColor);
          }
        });
  }
}
