import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scanner_app/models/receipts.dart';
import 'package:scanner_app/services/receipt_services.dart';
import 'package:scanner_app/services/settings_services.dart';
import 'package:scanner_app/shared/routes.dart';

class ReceiptTile extends StatelessWidget {
  final Receipt receipt;
  const ReceiptTile({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    bool showProfit = SettingsServices.getSettings().showPrice;
    return ListTile(
      onLongPress: () async {
        bool? result = await showDialog<bool>(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Center(
                child: Text('Are you sure you want to delete receipt?'),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    'No',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            );
          },
        );
        if (result != null && result) {
          ReceiptServices.deleteReceipt(receipt.id);
        }
      },
      onTap: () async {
        await Navigator.pushNamed(context, PageRoutes.ticketPage,
            arguments: receipt);
      },
      leading: const Icon(CupertinoIcons.money_dollar_circle_fill),
      title: Text(
        '${NumberFormat('###,###.##').format(showProfit ? receipt.totalPrice - receipt.totalCost : receipt.totalPrice)} L.L',
      ),
      subtitle: Text(DateFormat("jm").format(receipt.time)),
      trailing: Text('#1-1${NumberFormat('000').format(receipt.id)}'),
    );
  }
}
