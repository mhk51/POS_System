import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  static const String routeName = '/support';
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Page'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
