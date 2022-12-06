import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/ticket.dart';

class SalesItemTile extends StatelessWidget {
  final Item item;
  const SalesItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Ticket ticket = Provider.of(context);
    return ListTile(
      onTap: () {
        ticket.addItem(item);
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
        item.name!,
        style: const TextStyle(color: Colors.black, fontSize: 24),
      ),
      trailing: Text(
        '${NumberFormat('###,###.##').format(item.price)} L.L',
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }
}
