import 'package:flutter/material.dart';

class DrawerBodyItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String routeName;
  const DrawerBodyItem(
      {super.key,
      required this.icon,
      required this.routeName,
      required this.text});

  @override
  Widget build(BuildContext context) {
    String? pageRouteName = ModalRoute.of(context)?.settings.name;
    Color? selectedColor =
        pageRouteName == routeName ? Theme.of(context).primaryColor : null;
    return Container(
      margin: const EdgeInsets.all(3.0),
      child: ListTile(
          tileColor: pageRouteName == routeName ? Colors.grey[300] : null,
          title: Container(
            margin: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: selectedColor,
                  size: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: selectedColor,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, routeName);
          }),
    );
  }
}
