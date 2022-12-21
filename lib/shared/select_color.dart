import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/item_builder.dart';

class SelectColor extends StatefulWidget {
  final Function(Color color)? setSelectedColor;
  const SelectColor({super.key, this.setSelectedColor});

  @override
  State<SelectColor> createState() => _SelectColorState();
}

class _SelectColorState extends State<SelectColor> {
  List<Color> upperColors = [
    Colors.grey,
    Colors.red,
    Colors.pink,
    Colors.orange,
  ];
  List<Color> lowerColors = [
    Colors.lightGreen,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];
  Color selectedColor = Colors.grey;

  ElevatedButton textButtonFromColor(Color color) {
    ItemBuilder? item;
    try {
      item = Provider.of<ItemBuilder>(context);
      selectedColor = Color(item.color);
    } catch (e) {
      item == null;
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: color,
        elevation: 0,
      ),
      onPressed: () {
        if (item != null) {
          item.updateColor(color.value);
        } else {
          widget.setSelectedColor!(color);
        }
        setState(() {
          selectedColor = color;
        });
      },
      child: SizedBox(
        height: 80,
        width: 80,
        child: selectedColor.value == color.value
            ? const Icon(
                Icons.check,
                size: 30,
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: upperColors.map(textButtonFromColor).toList(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: lowerColors.map(textButtonFromColor).toList(),
        ),
      ],
    );
  }
}
