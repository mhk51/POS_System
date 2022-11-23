// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:scanner_app/dialog_box.dart';
import 'package:scanner_app/drawer/drawer.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/shared/loading.dart';
import 'package:scanner_app/services/services.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String scanBarcode = 'Unknown';

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      scanBarcode = barcodeScanRes;
    });
  }

  Future<Item?> getInfoFromDialog(Item? item) async {
    Item? response = await showDialog<Item>(
        // barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return DialogBox(item: item);
        });
    return response;
  }

  ListTile tileFromItem(Item item) {
    return ListTile(
      onTap: () async {
        Item? updatedItem = await getInfoFromDialog(item);
        if (updatedItem != null) {
          await Services.updateItem(updatedItem);
        }
        setState(() {});
      },
      leading: const Icon(Icons.circle),
      title: Text(
        item.name,
        style: const TextStyle(color: Colors.black, fontSize: 24),
      ),
      subtitle: Text(
        '${NumberFormat('###,###.##').format(item.price)} L.L',
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey[500],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('POS System'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder<List<Item>>(
          future: Services.getAllItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Item> data = snapshot.data!;
              return Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: ListView.separated(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return tileFromItem(data[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  ));
            } else {
              return const Loading(backGroundColor: Colors.white);
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          Item? item = await getInfoFromDialog(null);
          if (item != null) {
            await Services.insertItem(item);
          }
          setState(() {});
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
