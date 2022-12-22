import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/item_builder.dart';
import 'package:scanner_app/pages/add_item/delete_item.dart';
import 'package:scanner_app/pages/add_item/item_representation.dart';
import 'package:scanner_app/pages/add_item/stock_container.dart';

import 'item_details_container.dart';

class AddItem extends StatefulWidget {
  static const String routeName = '/add_item';
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  ItemBuilder? getItemData() {
    ItemBuilder? itemResponse =
        ModalRoute.of(context)!.settings.arguments as ItemBuilder?;
    if (itemResponse != null &&
        itemResponse.name == null &&
        itemResponse.barcode != null) {
      itemResponse = ItemBuilder(barcode: itemResponse.barcode);
    }
    return itemResponse;
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ItemBuilder? itemArg = getItemData();

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
                    Navigator.pop(context, Item.fromBuilder(itemBuilder));
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
                    const ItemDetailsContainer(),
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
  }
}
