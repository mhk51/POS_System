import 'package:flutter/material.dart';
import 'package:scanner_app/pages/sales_page/control_bar.dart';
import 'package:scanner_app/pages/sales_page/sales_items_list.dart';

class ItemsContainer extends StatelessWidget {
  const ItemsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ControlBar(),
        Divider(height: 0, thickness: 1),
        SalesItemsList(),
      ],
    );
  }
}
