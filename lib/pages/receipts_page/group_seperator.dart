import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scanner_app/models/receipts.dart';

class GroupSeperator extends StatelessWidget {
  final Receipt receipt;
  const GroupSeperator({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Text(
              DateFormat('yMMMMEEEEd').format(receipt.time),
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
          const Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}
