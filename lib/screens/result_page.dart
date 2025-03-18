import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc.dart';
import '../bloc/diamond_bloc.dart';
import '../data/diamond_model.dart';
import 'cart_page.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({required this.filteredDiamonds});
  final List<Diamond> filteredDiamonds;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String _sortBy = "Final Price (Asc)";
  void sortDiamonds() {
    setState(() {
      if (_sortBy == "Final Price (Asc)") {
        widget.filteredDiamonds.sort((a, b) => a.price.compareTo(b.price));
      } else if (_sortBy == "Final Price (Desc)") {
        widget.filteredDiamonds.sort((a, b) => b.price.compareTo(a.price));
      } else if (_sortBy == "Carat Weight (Asc)") {
        widget.filteredDiamonds.sort((a, b) => a.carat.compareTo(b.carat));
      } else if (_sortBy == "Carat Weight (Desc)") {
        widget.filteredDiamonds.sort((a, b) => b.carat.compareTo(a.carat));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Diamond List")),
      body: BlocBuilder<DiamondCubit, List<Diamond>>(
        builder: (context, diamonds) {
          return Column(
            children: [
              DropdownButton<String>(
                value: _sortBy,
                items: [
                  "Final Price (Asc)",
                  "Final Price (Desc)",
                  "Carat Weight (Asc)",
                  "Carat Weight (Desc)"
                ].map((sortOption) {
                  return DropdownMenuItem(
                      value: sortOption, child: Text(sortOption));
                }).toList(),
                onChanged: (value) {
                  setState(() => _sortBy = value!);
                  sortDiamonds();
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: diamonds.length,
                  itemBuilder: (context, index) {
                    final diamond = diamonds[index];
                    return ListTile(
                      title: Text("${diamond.shape} - \$${diamond.price}"),
                      subtitle: Text(diamond.displayAppData()),
                      trailing: IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        onPressed: () => context
                            .read<CartCubit>()
                            .addToCart(diamond, context),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartPage()));
          },
          child: Text("Go to Cart"),
        ),
      ),
    );
  }
}
