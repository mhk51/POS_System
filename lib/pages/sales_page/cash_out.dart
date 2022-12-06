import 'package:flutter/material.dart';
import 'package:scanner_app/models/ticket.dart';

class CashOut extends StatefulWidget {
  static const String routeName = "/cash_out";
  const CashOut({super.key});

  @override
  State<CashOut> createState() => _CashOutState();
}

class _CashOutState extends State<CashOut> {
  Ticket? ticket;
  @override
  Widget build(BuildContext context) {
    ticket ??= ModalRoute.of(context)?.settings.arguments as Ticket?;
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
