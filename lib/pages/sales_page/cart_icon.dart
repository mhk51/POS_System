import 'package:flutter/material.dart';
import 'package:scanner_app/models/ticket.dart';
import 'package:provider/provider.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    Ticket ticket = Provider.of(context);
    return Stack(
      children: <Widget>[
        const IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          onPressed: null,
        ),
        ticket.itemCount == 0
            ? Container()
            : Positioned(
                left: 30,
                child: Stack(
                  children: <Widget>[
                    Icon(
                      Icons.brightness_1,
                      size: 20.0,
                      color: Colors.green[800],
                    ),
                    Positioned(
                      top: 3.0,
                      right: ticket.itemCount > 10 ? 3.0 : 6.0,
                      child: Center(
                        child: Text(
                          ticket.itemCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
