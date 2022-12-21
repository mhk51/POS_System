import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scanner_app/models/receipts.dart';
import 'package:scanner_app/services/receipt_services.dart';
import 'package:scanner_app/shared/routes.dart';

class ReceiptTile extends StatelessWidget {
  final Receipt receipt;
  const ReceiptTile({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () => ReceiptServices.deleteReceipt(receipt.id),
      onTap: () async {
        await Navigator.pushNamed(context, PageRoutes.ticketPage,
            arguments: receipt);
      },
      leading: const Icon(CupertinoIcons.money_dollar_circle_fill),
      title: Text(
        '${NumberFormat('###,###.##').format(receipt.totalCost)} L.L',
      ),
      subtitle: Text(DateFormat("jm").format(receipt.time)),
      trailing: Text('#1-1${NumberFormat('000').format(receipt.id)}'),
    );
  }
}
