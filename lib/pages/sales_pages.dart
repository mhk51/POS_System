import 'package:flutter/material.dart';
import 'package:scanner_app/drawer/drawer.dart';

class SalesPage extends StatefulWidget {
  static const String routeName = "/sales";
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Sales Page'),
      ),
    );
  }
}
