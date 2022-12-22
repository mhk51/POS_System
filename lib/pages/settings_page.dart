import 'package:flutter/material.dart';
import 'package:scanner_app/drawer/drawer.dart';
import 'package:scanner_app/models/settings.dart';
import 'package:scanner_app/services/settings_services.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settings';
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool showPrice = SettingsServices.getSettings().showPrice;
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Settings Page'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Show Profit'),
          Switch(
            activeColor: Theme.of(context).primaryColor,
            value: showPrice,
            onChanged: (value) {
              SettingsServices.updateSettings(Settings(showPrice: value));
              setState(() {});
            },
          ),
        ],
      )),
    );
  }
}
