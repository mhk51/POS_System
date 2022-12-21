import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/drawer/drawer.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/ticket.dart';
import 'package:scanner_app/pages/sales_page/cart_icon.dart';
import 'package:scanner_app/pages/sales_page/charge_button.dart';
import 'package:scanner_app/pages/sales_page/control_bar.dart';
import 'package:scanner_app/pages/sales_page/sales_item_grid.dart';
import 'package:scanner_app/services/categories_services.dart';
import 'package:scanner_app/services/items_services.dart';
import 'package:scanner_app/shared/loading.dart';

class SalesPage extends StatefulWidget {
  static const String routeName = "/sales";
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  Future<Map<String, dynamic>> getInfo() async {
    List<Category?> categories = [...CategoriesServices.getAllCategories()];
    categories.add(null);
    List<Item> items = ItemServices.getAllItems();

    return {"categories": categories, "items": items};
  }

  Ticket? ticket;
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
                    value: ticket ??= Ticket(),
                  ),
                  Provider.value(value: items),
                  Provider.value(value: categories),
                ],
                builder: (context, snapshot) {
                  Ticket ticket = Provider.of(context);
                  return Scaffold(
                    drawer: const NavDrawer(),
                    appBar: AppBar(
                      title: Row(
                        children: const [
                          Text('Cart'),
                          SizedBox(width: 10),
                          CartIcon(),
                        ],
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () async {
                              bool? answer = await showDialog<bool>(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: const Text(
                                        'Are you sure you want to clear all items ?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: const Text('No')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                          child: const Text('Yes'))
                                    ],
                                  );
                                },
                              );
                              if (answer != null && answer) {
                                ticket.clear();
                              }
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ),
                      ],
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    body: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: const [
                            ControlBar(),
                            ChargeButton(),
                            // Divider(height: 0, thickness: 2),
                            SalesItemGrid(),
                          ],
                        ),
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
