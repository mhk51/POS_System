import 'package:flutter/material.dart';
import 'package:scanner_app/drawer.dart';

class ItemsPage extends StatefulWidget {
  static const String routeName = "/items";
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Items Page'),
      ),
    );
  }
}
