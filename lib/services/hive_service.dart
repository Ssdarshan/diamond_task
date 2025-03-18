import 'package:hive_flutter/hive_flutter.dart';

import '../data/diamond_model.dart';

class HiveService {
  static late Box<Diamond> cartBox;

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(DiamondAdapter());
    cartBox = await Hive.openBox<Diamond>('cartBox');
  }
}
