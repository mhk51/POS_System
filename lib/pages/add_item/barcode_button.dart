import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/item_builder.dart';

class BarcodeButton extends StatefulWidget {
  final TextEditingController barcodeTextController;
  const BarcodeButton({super.key, required this.barcodeTextController});

  @override
  State<BarcodeButton> createState() => _BarcodeButtonState();
}

class _BarcodeButtonState extends State<BarcodeButton> {
  @override
  Widget build(BuildContext context) {
    ItemBuilder item = Provider.of<ItemBuilder>(context);
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
        widget.barcodeTextController.text = barcodeScanRes;
      },
      splashColor: Theme.of(context).primaryColor,
    );
  }
}
