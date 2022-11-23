import 'package:flutter/material.dart';
import 'package:scanner_app/drawer/drawer.dart';

class ReceiptsPage extends StatefulWidget {
  static const String routeName = '/receipts';
  const ReceiptsPage({super.key});

  @override
  State<ReceiptsPage> createState() => _ReceiptsPageState();
}

class _ReceiptsPageState extends State<ReceiptsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Receipts Page'),
      ),
    );
  }
}
