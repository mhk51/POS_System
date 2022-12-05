import 'package:scanner_app/pages/add_category.dart';
import 'package:scanner_app/pages/add_item/add_item.dart';
import 'package:scanner_app/pages/back_office_page.dart';
import 'package:scanner_app/pages/categories_page.dart';
import 'package:scanner_app/pages/items_page/items_page.dart';
import 'package:scanner_app/pages/receipts_page.dart';
import 'package:scanner_app/pages/sales_pages.dart';
import 'package:scanner_app/pages/settings_page.dart';
import 'package:scanner_app/pages/support_page.dart';

class PageRoutes {
  static const String sales = SalesPage.routeName;
  static const String items = ItemsPage.routeName;
  static const String categories = CategoriesPage.routeName;
  static const String settings = SettingsPage.routeName;
  static const String receipts = ReceiptsPage.routeName;
  static const String support = SupportPage.routeName;
  static const String backOffice = BackOfficePage.routeName;
  static const String addCategory = AddCategory.routeName;
  static const String addItem = AddItem.routeName;
}
