import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/drawer/drawer.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/ticket.dart';
import 'package:scanner_app/pages/sales_page/charge_button.dart';
import 'package:scanner_app/pages/sales_page/items_container.dart';
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
    List<Future> futures = [
      CategoriesServices.getAllCategories(),
      ItemServices.getAllItems(),
    ];

    List reponses = await Future.wait(futures);
    List<Category?> categories = List.from(reponses[0]);
    categories.add(null);
    List<Item> items = reponses[1];

    return {"categories": categories, "items": items};
  }

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
                    value: Ticket(),
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
                        children: [
                          const Text('Cart'),
                          const SizedBox(width: 10),
                          Stack(
                            children: <Widget>[
                              const IconButton(
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                                onPressed: null,
                              ),
                              ticket.itemCount == 0
                                  ? Container()
                                  : Positioned(
                                      left: 30,
                                      child: Stack(
                                        children: <Widget>[
                                          Icon(
                                            Icons.brightness_1,
                                            size: 20.0,
                                            color: Colors.green[800],
                                          ),
                                          Positioned(
                                            top: 3.0,
                                            right: 5.0,
                                            child: Center(
                                              child: Text(
                                                ticket.itemCount.toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                      actions: [
                        PopupMenuButton(
                          color: Colors.white,
                          itemBuilder: ((context) {
                            return [
                              PopupMenuItem(
                                value: 0,
                                child: ListTile(
                                  leading: const Icon(Icons.delete),
                                  onTap: () {
                                    ticket.clear();
                                    Navigator.pop(context);
                                  },
                                  title: const Text('Clear Ticket'),
                                ),
                              ),
                            ];
                          }),
                        )
                      ],
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    body: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: const [
                            ChargeButton(),
                            Divider(height: 0, thickness: 2),
                            ItemsContainer(),
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
