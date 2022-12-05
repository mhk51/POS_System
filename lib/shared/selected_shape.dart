import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/item.dart';

class SelectedShape extends StatefulWidget {
  const SelectedShape({super.key});

  @override
  State<SelectedShape> createState() => _SelectedShapeState();
}

class _SelectedShapeState extends State<SelectedShape> {
  Align checkIcon = const Align(
    alignment: Alignment.center,
    child: Icon(
      Icons.check,
      size: 30,
    ),
  );

  List<IconData> icons = [
    Icons.circle,
    Icons.square,
    Icons.hexagon,
    Icons.water_drop_rounded
  ];

  List<IconData> representation = [
    Icons.circle_outlined,
    Icons.square_outlined,
    Icons.hexagon_outlined,
    Icons.water_drop_outlined,
  ];

  int getIndexFromItem(Item item) {
    return icons.indexOf(item.shape);
  }

  Stack selectableShape(int index) {
    Item item = Provider.of<Item>(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        selectedShape == index ? checkIcon : Container(),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          onPressed: () {
            setState(() {
              item.updateShape(icons[index]);
              selectedShape = index;
            });
          },
          child: Icon(
            representation[index],
            color: Colors.black,
            size: 80,
          ),
        ),
      ],
    );
  }

  int? selectedShape;
  @override
  Widget build(BuildContext context) {
    Item item = Provider.of<Item>(context);
    selectedShape = getIndexFromItem(item);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          selectableShape(0),
          selectableShape(1),
          selectableShape(2),
          selectableShape(3),
        ],
      ),
    );
  }
}
