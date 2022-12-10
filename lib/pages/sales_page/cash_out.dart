import 'package:flutter/material.dart';
import 'package:scanner_app/models/ticket.dart';
import 'package:scanner_app/services/ticket_services.dart';

class CashOut extends StatelessWidget {
  static const String routeName = "/cash_out";
  const CashOut({super.key});

  @override
  Widget build(BuildContext context) {
    Ticket ticket = ModalRoute.of(context)?.settings.arguments as Ticket;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          TicketServices.insertTicket(ticket);
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        child: const Text('Cash Out'),
      )),
    );
  }
}
