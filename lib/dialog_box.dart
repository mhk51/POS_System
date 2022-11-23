// ignore_for_file: empty_catches

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scanner_app/constants.dart';
import 'package:scanner_app/item.dart';

class DialogBox extends StatefulWidget {
  final Item? item;
  const DialogBox({Key? key, this.item}) : super(key: key);

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String itemName = "";
  double itemPrice = 0;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      itemName = widget.item!.name;
      itemPrice = widget.item!.price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Add Item',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Enter item details',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
      content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: TextFormField(
                  initialValue: widget.item != null ? widget.item!.name : null,
                  validator: (value) {
                    return value!.isNotEmpty ? null : "Invalid Field";
                  },
                  onChanged: (value) {
                    itemName = value;
                  },
                  decoration: textfieldDecoration.copyWith(labelText: 'Item Name'),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: TextFormField(
                  initialValue: widget.item != null ? widget.item!.price.toString() : null,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return value!.isNotEmpty ? null : "Invalid Field";
                  },
                  onChanged: (value) {
                    try {
                      itemPrice = double.parse(value);
                    } catch (e) {}
                  },
                  decoration: textfieldDecoration.copyWith(labelText: 'Item Price'),
                ),
              ),
            ],
          )),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Item item = Item(
                barcode: widget.item != null
                    ? widget.item!.barcode
                    : Random().nextInt(100000).toString(),
                name: itemName,
                price: itemPrice,
              );
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).pop(item);
              }
            },
            child: const Text("Submit"))
      ],
    );
  }
}
