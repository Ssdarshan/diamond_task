import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/data.dart';
import '../data/diamond_model.dart';

class DiamondCubit extends Cubit<List<Diamond>> {
  DiamondCubit() : super(diamonds);

  void filterDiamonds(
      {double? minCarat,
      double? maxCarat,
      String? lab,
      String? shape,
      String? color,
      String? clarity}) {
    List<Diamond> filteredList = diamonds.where((d) {
      bool matchesCarat = (minCarat == null || d.carat >= minCarat) &&
          (maxCarat == null || d.carat <= maxCarat);
      bool matchesLab = (lab == null || d.lab == lab);
      bool matchesShape = (shape == null || d.shape == shape);
      bool matchesColor = (color == null || d.color == color);
      bool matchesClarity = (clarity == null || d.clarity == clarity);
      return matchesCarat &&
          matchesLab &&
          matchesShape &&
          matchesColor &&
          matchesClarity;
    }).toList();
    emit(filteredList);
  }
}
