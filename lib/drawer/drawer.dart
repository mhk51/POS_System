// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:scanner_app/drawer/drawer_item.dart';
import 'package:scanner_app/pages/routes.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Owner',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'POS 1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Local',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const DrawerBodyItem(
            icon: Icons.home,
            text: 'Home',
            routeName: PageRoutes.home,
          ),
          const DrawerBodyItem(
            icon: Icons.shopping_basket_sharp,
            text: 'Sales',
            routeName: PageRoutes.sales,
          ),
          const DrawerBodyItem(
            icon: Icons.receipt,
            text: 'Receipts',
            routeName: PageRoutes.receipts,
          ),
          const DrawerBodyItem(
            icon: Icons.list,
            text: 'Items',
            routeName: PageRoutes.items,
          ),
          const DrawerBodyItem(
            icon: Icons.category,
            text: 'Categories',
            routeName: PageRoutes.categories,
          ),
          const DrawerBodyItem(
            icon: Icons.settings,
            text: 'Settings',
            routeName: PageRoutes.settings,
          ),
        ],
      ),
    );
  }
}
