import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/item.dart';
import 'package:scanner_app/models/ticket.dart';

class SalesItemGrid extends StatefulWidget {
  const SalesItemGrid({super.key});

  @override
  State<SalesItemGrid> createState() => _SalesItemGridState();
}

class _SalesItemGridState extends State<SalesItemGrid> {
  List<int> quantities = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];

  DropdownMenuItem dropDownFromInt(int n) {
    return DropdownMenuItem(value: n, child: Text(n.toString()));
  }

  DataRow rowFromItem(MapEntry<Item, int> entry) {
    Ticket ticket = Provider.of(context);
    Item item = entry.key;
    int price = item.price;
    int qty = entry.value;
    return DataRow(
      cells: [
        DataCell(SizedBox(
          width: 40,
          child: Icon(
            IconData(item.shape, fontFamily: "MaterialIcons"),
            color: Color(item.color),
            size: 35,
          ),
        )),
        DataCell(
          SizedBox(width: 120, child: Text(item.name)),
        ),
        DataCell(
          SizedBox(
            width: 44,
            child: DropdownButton(
              menuMaxHeight: 500,
              alignment: AlignmentDirectional.topStart,
              value: qty,
              items: quantities.map(dropDownFromInt).toList(),
              onChanged: (value) => ticket.setItemQuantity(item, value),
            ),
          ),
        ),
        DataCell(
          SizedBox(
              width: 100,
              child: Text(
                  ('${NumberFormat('#,###,###.##').format(price * qty)} L.L'))),
        ),
        DataCell(
          SizedBox(
            width: 30,
            child: IconButton(
              style: IconButton.styleFrom(padding: EdgeInsets.zero),
              icon: const Icon(Icons.delete),
              onPressed: () => ticket.removeItem(item),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Ticket ticket = Provider.of(context);
    List<MapEntry<Item, int>> items = ticket.items.entries.toList();

    List<DataRow> rows = items.map(rowFromItem).toList();
    return ticket.items.isEmpty
        ? const EmptyCart()
        : Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.green,
            child: DataTable(
              dataRowColor: MaterialStateProperty.all(Colors.grey[100]),
              horizontalMargin: 0,
              headingRowHeight: 40,
              columnSpacing: 0,
              dataRowHeight: 80,
              // columnSpacing: 50,
              columns: const [
                DataColumn(label: SizedBox()),
                DataColumn(
                  label: Text(
                    'Name',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Qty',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                DataColumn(label: SizedBox())
              ],
              rows: rows,
            ),
          );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1000,
      height: 550,
      child: ColorFiltered(
        colorFilter:
            ColorFilter.mode(Colors.green.withOpacity(1), BlendMode.color),
        child: Image.asset(
          'assets/cart.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
