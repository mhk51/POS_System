import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/ticket.dart';
import 'package:scanner_app/shared/routes.dart';

class ChargeButton extends StatelessWidget {
  const ChargeButton({super.key});

  @override
  Widget build(BuildContext context) {
    Ticket ticket = Provider.of<Ticket>(context);
    return Container(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          child: ticket.itemCount == 0
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Charge',
                        style: TextStyle(
                          color: Colors.green[200],
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '0.00 L.L',
                        style: TextStyle(
                          color: Colors.green[200],
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                )
              : TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, PageRoutes.cashOut,
                        arguments: ticket);
                  },
                  child: Column(
                    children: [
                      const Text(
                        'Charge',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${NumberFormat('###,###.##').format(ticket.totalCost)} L.L',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
