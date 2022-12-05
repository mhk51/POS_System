import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/item.dart';

class BarcodeButton extends StatefulWidget {
  const BarcodeButton({super.key});

  @override
  State<BarcodeButton> createState() => _BarcodeButtonState();
}

class _BarcodeButtonState extends State<BarcodeButton> {
  @override
  Widget build(BuildContext context) {
    Item item = Provider.of<Item>(context);
    return IconButton(
      icon: Icon(
        CupertinoIcons.barcode_viewfinder,
        color: Colors.grey[700],
        size: 30,
      ),
      onPressed: () async {
        String barcodeScanRes;
        try {
          barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              '#ff6666', 'Cancel', true, ScanMode.BARCODE);
        } on PlatformException {
          barcodeScanRes = 'Failed to get platform version.';
        }
        if (!mounted) return;
        item.updateBarcode(barcodeScanRes);
      },
      splashColor: Theme.of(context).primaryColor,
    );
  }
}
