import 'package:flutter/material.dart';

class BackOfficePage extends StatefulWidget {
  static const String routeName = '/back_office';
  const BackOfficePage({super.key});

  @override
  State<BackOfficePage> createState() => _BackOfficePageState();
}

class _BackOfficePageState extends State<BackOfficePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back Office Page'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
