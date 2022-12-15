import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/shared/routes.dart';
import 'package:scanner_app/services/items_services.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  final Function callBack;
  const ItemTile({super.key, required this.item, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () async {
            Item? updatedItem = await Navigator.pushNamed(
                context, PageRoutes.addItem,
                arguments: item) as Item?;
            if (updatedItem != null) {
              await ItemServices.insertItem(updatedItem);
            }
            callBack();
          },
          leading: SizedBox(
            height: double.infinity,
            width: 60,
            child: item.image == null
                ? Icon(
                    item.shape,
                    color: item.color,
                    size: 50,
                  )
                : CircleAvatar(
                    backgroundImage: FileImage(item.image!),
                    radius: 25,
                  ),
          ),
          title: Text(
            item.name,
            style: const TextStyle(color: Colors.black, fontSize: 24),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              item.stockCount != null ? "${item.stockCount} in stock" : "-",
              style: const TextStyle(fontSize: 16),
            ),
          ),
          trailing: Text(
            '${NumberFormat('###,###.##').format(item.price)} L.L',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 75.0),
          child: Divider(thickness: 2),
        )
      ],
    );
  }
}
