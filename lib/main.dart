// ignore_for_file: avoid_print
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scanner_app/pages/add_category.dart';
import 'package:scanner_app/pages/add_item/add_item.dart';
import 'package:scanner_app/pages/back_office_page.dart';
import 'package:scanner_app/pages/categories_page.dart';
import 'package:scanner_app/pages/items_page/items_page.dart';
import 'package:scanner_app/pages/receipts_page/receipts_page.dart';
import 'package:scanner_app/pages/sales_page/cash_out.dart';
import 'package:scanner_app/pages/sales_page/sales_pages.dart';
import 'package:scanner_app/pages/settings_page.dart';
import 'package:scanner_app/pages/receipts_page/ticket_page.dart';
import 'package:scanner_app/shared/routes.dart';
import 'package:scanner_app/pages/support_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[400],
        cardColor: Colors.green[500],
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
        PageRoutes.addItem: (context) => const AddItem(),
        PageRoutes.cashOut: (context) => const CashOut(),
        PageRoutes.ticketPage: (context) => const TicketPage(),
      },
    );
  }
}
