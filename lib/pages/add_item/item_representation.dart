import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/shared/select_color.dart';
import 'package:scanner_app/pages/add_item/select_image.dart';
import 'package:scanner_app/shared/selected_shape.dart';

class ItemRepresentation extends StatefulWidget {
  const ItemRepresentation({super.key});

  @override
  State<ItemRepresentation> createState() => _ItemRepresentationState();
}

class _ItemRepresentationState extends State<ItemRepresentation> {
  RepresentationType? representationType;

  @override
  Widget build(BuildContext context) {
    Item item = Provider.of<Item>(context);
    representationType ??= item.image == null
        ? RepresentationType.Shape
        : RepresentationType.Image;
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
              'Representation on POS',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: Radio<RepresentationType>(
                      activeColor: Theme.of(context).primaryColor,
                      value: RepresentationType.Shape,
                      groupValue: representationType,
                      onChanged: (RepresentationType? value) {
                        setState(() {
                          representationType = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Color and Shape',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: Radio<RepresentationType>(
                      activeColor: Theme.of(context).primaryColor,
                      value: RepresentationType.Image,
                      groupValue: representationType,
                      onChanged: (RepresentationType? value) {
                        setState(() {
                          representationType = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Image',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            representationType == RepresentationType.Shape
                ? Column(
                    children: const [
                      SelectColor(),
                      SelectedShape(),
                    ],
                  )
                : const SelectImage(),
          ],
        ),
      ),
    );
  }
}
