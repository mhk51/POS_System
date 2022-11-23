import 'package:flutter/material.dart';

class DrawerBodyItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String routeName;
  const DrawerBodyItem(
      {super.key, required this.icon, required this.routeName, required this.text});

  @override
  Widget build(BuildContext context) {
    String? pageRouteName = ModalRoute.of(context)?.settings.name;
    Color? selectedColor = pageRouteName == routeName ? Theme.of(context).primaryColor : null;
    return ListTile(
      tileColor: pageRouteName == routeName ? Colors.grey[300] : null,
      title: Row(
        children: <Widget>[
          Icon(icon, color: selectedColor),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: TextStyle(color: selectedColor),
            ),
          )
        ],
      ),
      onTap: () => Navigator.pushReplacementNamed(context, routeName),
    );
  }
}
