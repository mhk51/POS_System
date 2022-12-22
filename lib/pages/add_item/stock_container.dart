// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/item_builder.dart';

class StockContainer extends StatefulWidget {
  const StockContainer({super.key});

  @override
  State<StockContainer> createState() => _StockContainerState();
}

class _StockContainerState extends State<StockContainer> {
  FocusNode stockCountFocus = FocusNode();
  int stockCount = 0;

  void _requestFocusStock() {
    setState(() {
      FocusScope.of(context).requestFocus(stockCountFocus);
    });
  }

  late bool trackStockBool;

  @override
  void initState() {
    super.initState();
    ItemBuilder item = Provider.of<ItemBuilder>(context, listen: false);
    trackStockBool = item.stockCount != null;
  }

  @override
  Widget build(BuildContext context) {
    ItemBuilder item = Provider.of<ItemBuilder>(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Inventory',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Track stock',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Switch(
                  activeColor: Theme.of(context).primaryColor,
                  value: trackStockBool,
                  onChanged: (value) {
                    setState(() {
                      trackStockBool = value;
                    });
                  },
                ),
              ],
            ),
            trackStockBool
                ? TextFormField(
                    validator: (value) {
                      if (value == null) return "Please Enter Valid Number";
                      return int.tryParse(value) != null
                          ? null
                          : "Please Enter Valid Number";
                    },
                    initialValue: item.stockCount?.toString(),
                    onChanged: (value) {
                      if (value == "") {
                        item.updateStock(0);
                      } else {
                        try {
                          item.updateStock(int.parse(value));
                        } catch (e) {}
                      }
                    },
                    keyboardType: TextInputType.number,
                    focusNode: stockCountFocus,
                    onTap: _requestFocusStock,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      labelText: 'In stock',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      focusColor: Theme.of(context).primaryColor,
                      labelStyle: TextStyle(
                        color: stockCountFocus.hasFocus
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
