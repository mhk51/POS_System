import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/item_builder.dart';
import 'package:scanner_app/services/items_services.dart';

class DeleteItem extends StatefulWidget {
  const DeleteItem({super.key});

  @override
  State<DeleteItem> createState() => _DeleteItemState();
}

class _DeleteItemState extends State<DeleteItem> {
  @override
  Widget build(BuildContext context) {
    ItemBuilder item = Provider.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          ),
        ],
      ),
      child: TextButton.icon(
        onPressed: () async {
          ItemServices.deleteItem(item.id);
          if (mounted) {
            Navigator.pop(context);
          }
        },
        icon: Icon(
          Icons.delete,
          color: Colors.grey[600],
        ),
        label: Text(
          'DELETE ITEM',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
      ),
    );
  }
}
