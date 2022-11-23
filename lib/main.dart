// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:scanner_app/pages/home_page.dart';
import 'package:scanner_app/pages/categories_page.dart';
import 'package:scanner_app/pages/items_page.dart';
import 'package:scanner_app/pages/receipts_page.dart';
import 'package:scanner_app/pages/sales_pages.dart';
import 'package:scanner_app/pages/settings_page.dart';
import 'package:scanner_app/pages/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      initialRoute: PageRoutes.home,
      routes: {
        PageRoutes.home: (context) => const HomePage(),
        PageRoutes.sales: (context) => const SalesPage(),
        PageRoutes.items: (context) => const ItemsPage(),
        PageRoutes.categories: (context) => const CategoriesPage(),
        PageRoutes.settings: (context) => const SettingsPage(),
        PageRoutes.receipts: (context) => const ReceiptsPage(),
      },
    );
  }
}
