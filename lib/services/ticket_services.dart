import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/receipts.dart';
import 'package:scanner_app/models/ticket.dart';

class TicketServices {
  static final ticketsCollection =
      FirebaseFirestore.instance.collection('tickets');
  static Future<void> insertTicket(Ticket ticket) async {
    Map<String, dynamic> data = await ticket.toMap();
    await ticketsCollection.doc().set(data);
  }

  static Receipt receiptfromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.get('items') as Map;
    Map<Item, int> items = {};
    for (Map<String, dynamic> itemMap in data.values) {
      Item item = Item(
        name: itemMap['name'],
        price: itemMap['price'],
        barcode: itemMap['barcode'],
        color: Color(itemMap['color']),
        shape: IconData(itemMap['shape'], fontFamily: "MaterialIcons"),
        cost: itemMap['cost'],
        image: itemMap['image'],
      );

      items[item] = itemMap['qty'];
    }

    return Receipt(
      itemCount: snapshot.get('itemCount'),
      items: items,
      totalCost: snapshot.get('totalCost'),
      time: snapshot.get('time').toDate(),
      receciptNumber: snapshot.get('ticketNumber'),
    );
  }

  static Future<List<Receipt>> getAllReciepts() async {
    List<DocumentSnapshot> docs = (await ticketsCollection.get()).docs;
    return docs.map(receiptfromSnapshot).toList();
  }
}
