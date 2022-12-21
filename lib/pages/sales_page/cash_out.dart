// ignore_for_file: empty_catches

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scanner_app/models/receipts.dart';
import 'package:scanner_app/models/ticket.dart';
import 'package:scanner_app/services/receipt_services.dart';

class CashOut extends StatefulWidget {
  static const String routeName = "/cash_out";
  const CashOut({super.key});

  @override
  State<CashOut> createState() => _CashOutState();
}

class _CashOutState extends State<CashOut> {
  int? cashReceived;

  @override
  Widget build(BuildContext context) {
    Ticket ticket = ModalRoute.of(context)?.settings.arguments as Ticket;
    cashReceived ??= ticket.totalCost;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'SPLIT',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  '${NumberFormat('###,###.##').format(ticket.totalCost)} L.L',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text('Total Amount due',
                    style: TextStyle(color: Colors.grey, fontSize: 18)),
              ),
            ),
            const SizedBox(height: 50),
            Text(
              'Cash received',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            TextFormField(
              onChanged: (value) {
                try {
                  cashReceived = int.parse(value);
                  setState(() {});
                } catch (e) {}
              },
              initialValue: ticket.totalCost.toString(),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.5,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.5,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(width: 1, color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(3)),
              child: cashReceived! >= ticket.totalCost
                  ? TextButton.icon(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: SizedBox(
                                height: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              '${NumberFormat('###,###.##').format(ticket.totalCost)} L.L',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            const Text('Total paid'),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      thickness: 2,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              '${NumberFormat('###,###.##').format(cashReceived! - ticket.totalCost)} L.L',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            const Text('Change'),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        Receipt receipt = Receipt.fromTicket(ticket);
                        ReceiptServices.insertReceipt(receipt);
                        ticket.clear();
                        if (!mounted) return;
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        shape: const StadiumBorder(),
                        foregroundColor: Colors.grey[700],
                      ),
                      icon: const Icon(CupertinoIcons.money_dollar_circle_fill),
                      label: const Text('Cash Out'),
                    )
                  : TextButton.icon(
                      onPressed: null,
                      style: TextButton.styleFrom(
                        shape: const StadiumBorder(),
                        foregroundColor: Colors.grey[700],
                      ),
                      icon: const Icon(CupertinoIcons.money_dollar_circle_fill),
                      label: const Text('Cash Out'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
