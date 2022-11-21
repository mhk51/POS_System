// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:scanner_app/dialog_box.dart';
import 'package:scanner_app/item.dart';
import 'package:scanner_app/loading.dart';
import 'package:scanner_app/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        barrierDismissible: false,
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('POS System')),
        body: FutureBuilder<List<Item>>(
            future: Services.getAllItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<Item> data = snapshot.data!;
                return Container(
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
          onPressed: () async {
            Item? item = await getInfoFromDialog(null);
            if (item != null) {
              await Services.insertItem(item);
            }
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
