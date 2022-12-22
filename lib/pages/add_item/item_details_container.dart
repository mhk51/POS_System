import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/category.dart';
import 'package:scanner_app/models/item_builder.dart';
import 'package:scanner_app/pages/add_item/barcode_button.dart';
import 'package:scanner_app/pages/add_item/item_category_dropdown.dart';
import 'package:scanner_app/services/categories_services.dart';

class ItemDetailsContainer extends StatefulWidget {
  const ItemDetailsContainer({super.key});

  @override
  State<ItemDetailsContainer> createState() => _ItemDetailsContainerState();
}

class _ItemDetailsContainerState extends State<ItemDetailsContainer> {
  FocusNode nameFocus = FocusNode();
  FocusNode costFocus = FocusNode();
  FocusNode priceFocus = FocusNode();
  FocusNode barcodeFocus = FocusNode();

  TextEditingController barcodeTextController = TextEditingController();

  void _requestFocusName() {
    setState(() {
      FocusScope.of(context).requestFocus(nameFocus);
    });
  }

  void _requestFocusPrice() {
    setState(() {
      FocusScope.of(context).requestFocus(priceFocus);
    });
  }

  void _requestFocusCost() {
    setState(() {
      FocusScope.of(context).requestFocus(costFocus);
    });
  }

  void _requestFocusBarcode() {
    setState(() {
      FocusScope.of(context).requestFocus(barcodeFocus);
    });
  }

  InputDecoration inputDecoration(String label, FocusNode focusNode) {
    return InputDecoration(
      contentPadding: EdgeInsets.zero,
      labelText: label,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Theme.of(context).primaryColor,
        ),
      ),
      focusColor: Theme.of(context).primaryColor,
      labelStyle: TextStyle(
        color: focusNode.hasFocus ? Theme.of(context).primaryColor : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ItemBuilder item = Provider.of<ItemBuilder>(context);
    if (item.barcode != null) {
      barcodeTextController.text = item.barcode!;
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
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
            TextFormField(
              initialValue: item.name,
              validator: (value) {
                return value!.isNotEmpty ? null : "Please Enter a Name";
              },
              onChanged: (value) {
                item.updateName(value);
              },
              focusNode: nameFocus,
              onTap: _requestFocusName,
              decoration: inputDecoration('Name', nameFocus),
            ),
            const SizedBox(height: 20),
            const Text('Category'),
            const CategoryDropDown(),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: item.price?.toString(),
              validator: (value) {
                return value!.isNotEmpty ? null : "Please Enter a Price";
              },
              onChanged: (value) {
                if (value == "") {
                  item.updatePrice(0);
                } else {
                  item.updatePrice(int.parse(value.replaceAll(",", "")));
                }
              },
              keyboardType: TextInputType.number,
              focusNode: priceFocus,
              onTap: _requestFocusPrice,
              decoration: inputDecoration('Price', priceFocus),
            ),
            const SizedBox(height: 20),
            TextFormField(
              onChanged: (value) {
                if (value == "") {
                  item.updateCost(0);
                } else {
                  item.updateCost(int.parse(value.replaceAll(",", "")));
                }
              },
              initialValue: item.cost.toString(),
              keyboardType: TextInputType.number,
              focusNode: costFocus,
              onTap: _requestFocusCost,
              decoration: inputDecoration('Cost', costFocus),
            ),
            const SizedBox(height: 20),
            TextFormField(
              onChanged: (value) {
                item.updateBarcode(value);
              },
              focusNode: barcodeFocus,
              controller: barcodeTextController,
              onTap: _requestFocusBarcode,
              decoration: inputDecoration('Barcode', barcodeFocus).copyWith(
                  suffixIcon: BarcodeButton(
                barcodeTextController: barcodeTextController,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
