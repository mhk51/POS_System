// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:scanner_app/pages/add_category.dart';
import 'package:scanner_app/pages/back_office_page.dart';
import 'package:scanner_app/pages/categories_page.dart';
import 'package:scanner_app/pages/items_page.dart';
import 'package:scanner_app/pages/receipts_page.dart';
import 'package:scanner_app/pages/sales_pages.dart';
import 'package:scanner_app/pages/settings_page.dart';
import 'package:scanner_app/pages/routes.dart';
import 'package:scanner_app/pages/support_page.dart';
import 'package:scanner_app/services/categories_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await CategoriesServices.dropTable();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[500],
      ),
      initialRoute: PageRoutes.sales,
      routes: {
        PageRoutes.sales: (context) => const SalesPage(),
        PageRoutes.items: (context) => const ItemsPage(),
        PageRoutes.categories: (context) => const CategoriesPage(),
        PageRoutes.settings: (context) => const SettingsPage(),
        PageRoutes.receipts: (context) => const ReceiptsPage(),
        PageRoutes.support: (context) => const SupportPage(),
        PageRoutes.backOffice: (context) => const BackOfficePage(),
        PageRoutes.addCategory: (context) => const AddCategory(),
      },
    );
  }
}
