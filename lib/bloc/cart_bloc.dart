import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/diamond_model.dart';
import '../services/hive_service.dart';
import '../utils/common_utilities.dart';

class CartCubit extends Cubit<List<Diamond>> {
  CartCubit() : super(List<Diamond>.from(HiveService.cartBox.values));

  void addToCart(Diamond diamond, BuildContext context) {
    HiveService.cartBox.put(diamond.lotId, diamond);
    emit(List<Diamond>.from(HiveService.cartBox.values));
    commonSnackBar(message: "Success", context: context);
  }

  void removeFromCart(String lotId, BuildContext context) {
    HiveService.cartBox.delete(lotId);
    emit(List<Diamond>.from(HiveService.cartBox.values));
    commonSnackBar(
        message: "Removed", context: context, type: SnackBarType.success);
  }
}
