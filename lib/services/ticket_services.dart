import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scanner_app/models/ticket.dart';

class TicketServices {
  static final ticketsCollection =
      FirebaseFirestore.instance.collection('tickets');
  static Future<void> insertTicket(Ticket ticket) async {
    await ticketsCollection.doc().set(ticket.toMap());
  }
}
