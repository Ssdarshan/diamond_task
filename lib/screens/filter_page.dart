import 'package:diamond_task/screens/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/diamond_bloc.dart';
import '../data/diamond_model.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  TextEditingController searchController = TextEditingController();
  List<Diamond> filteredDiamonds = [];

  // Filter options
  double? minCarat, maxCarat;
  String? selectedLab, selectedShape, selectedColor, selectedClarity;

  @override
  void initState() {
    super.initState();
    filteredDiamonds = context.read<DiamondCubit>().state;
  }

  void applySearch(String query) {
    final allDiamonds = context.read<DiamondCubit>().state;
    setState(() {
      filteredDiamonds = allDiamonds.where((diamond) {
        return diamond.lotId.toLowerCase().contains(query.toLowerCase()) ||
            diamond.shape.toLowerCase().contains(query.toLowerCase()) ||
            diamond.color.toLowerCase().contains(query.toLowerCase()) ||
            diamond.lab.toLowerCase().contains(query.toLowerCase()) ||
            diamond.clarity.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void applyFilters() {
    // final allDiamonds = context.read<DiamondCubit>().state;
    context.read<DiamondCubit>().filterDiamonds(
        shape: selectedShape,
        color: selectedColor,
        clarity: selectedClarity,
        lab: selectedLab,
        maxCarat: maxCarat,
        minCarat: minCarat);
    Navigator.pop(context); // Close bottom sheet
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultPage(
                filteredDiamonds: context.read<DiamondCubit>().state)));
  }

  void openFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setSheetState) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Carat Filter
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: "Min Carat"),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          minCarat = double.tryParse(value);
                          setSheetState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: "Max Carat"),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          maxCarat = double.tryParse(value);
                          setSheetState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                // Lab Filter
                DropdownButton<String>(
                  hint: Text("Select Lab"),
                  value: selectedLab,
                  isExpanded: true,
                  items: ["GIA", "IGI", "HRD"].map((lab) {
                    return DropdownMenuItem(value: lab, child: Text(lab));
                  }).toList(),
                  onChanged: (value) {
                    selectedLab = value;
                    setSheetState(() {});
                  },
                ),

                // Shape Filter
                DropdownButton<String>(
                  hint: Text("Select Shape"),
                  value: selectedShape,
                  isExpanded: true,
                  items:
                      ["BR", "CU", "EM", "MQ", "OV", "PS", "RAD"].map((shape) {
                    return DropdownMenuItem(value: shape, child: Text(shape));
                  }).toList(),
                  onChanged: (value) {
                    selectedShape = value;
                    setSheetState(() {});
                  },
                ),

                // Color Filter
                DropdownButton<String>(
                  hint: Text("Select Color"),
                  value: selectedColor,
                  isExpanded: true,
                  items: ["D", "E", "F", "G", "H"].map((color) {
                    return DropdownMenuItem(value: color, child: Text(color));
                  }).toList(),
                  onChanged: (value) {
                    selectedColor = value;
                    setSheetState(() {});
                  },
                ),

                // Clarity Filter
                DropdownButton<String>(
                  hint: Text("Select Clarity"),
                  value: selectedClarity,
                  isExpanded: true,
                  items: ["IF", "VVS1", "VVS2", "VS1", "VS2"].map((clarity) {
                    return DropdownMenuItem(
                        value: clarity, child: Text(clarity));
                  }).toList(),
                  onChanged: (value) {
                    selectedClarity = value;
                    setSheetState(() {});
                  },
                ),

                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: applyFilters,
                  child: Text("Apply Filters"),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Filter Diamonds")),
      body: Column(
        children: [
          // Search Field with Filter Button
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: searchController,
              onChanged: applySearch,
              decoration: InputDecoration(
                labelText: "Search diamonds...",
                suffixIcon: IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: openFilterSheet,
                ),
              ),
            ),
          ),

          // Diamond List
          Expanded(
            child: ListView.builder(
              itemCount: filteredDiamonds.length,
              itemBuilder: (context, index) {
                final diamond = filteredDiamonds[index];
                return ListTile(
                  title: Text("Lot ID: ${diamond.lotId}"),
                  subtitle: Text(diamond.displayAppData()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
