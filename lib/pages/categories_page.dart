import 'package:flutter/material.dart';
import 'package:scanner_app/drawer/drawer.dart';

class CategoriesPage extends StatefulWidget {
  static const String routeName = '/categories';
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Categorie Page'),
      ),
    );
  }
}
