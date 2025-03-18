import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc.dart';
import '../data/diamond_model.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: BlocBuilder<CartCubit, List<Diamond>>(
        builder: (context, cartItems) {
          if (cartItems.isEmpty) {
            return Center(child: Text("No items in cart"));
          }

          double totalCarat =
              cartItems.fold(0, (sum, item) => sum + item.carat);
          double totalPrice =
              cartItems.fold(0, (sum, item) => sum + item.price);
          double avgPrice =
              totalPrice / (cartItems.isEmpty ? 1 : cartItems.length);
          double avgDiscount =
              cartItems.fold(0, (sum, item) => (sum + item.discount).toInt()) /
                  (cartItems.isEmpty ? 1 : cartItems.length);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final diamond = cartItems[index];
                    return ListTile(
                      title: Text("Lot ID: ${diamond.lotId}"),
                      subtitle: Text(diamond.displayAppData()),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          BlocProvider.of<CartCubit>(context)
                              .removeFromCart(diamond.lotId, context);
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text("Total Carat: $totalCarat",
                        style: TextStyle(fontSize: 16, color: Colors.red)),
                    Text("Total Price: \$${totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 16)),
                    Text("Avg Price: \$${avgPrice.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 16)),
                    Text("Avg Discount: ${avgDiscount.toStringAsFixed(2)}%",
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
