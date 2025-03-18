import 'package:hive/hive.dart';

part 'diamond_model.g.dart';

@HiveType(typeId: 0)
class Diamond extends HiveObject {
  @HiveField(0)
  String lotId;
  @HiveField(1)
  String size;
  @HiveField(2)
  double carat;
  @HiveField(3)
  String lab;
  @HiveField(4)
  String shape;
  @HiveField(5)
  String color;
  @HiveField(6)
  String clarity;
  @HiveField(7)
  String cut;
  @HiveField(8)
  String polish;
  @HiveField(9)
  String symmetry;
  @HiveField(10)
  String fluorescence;
  @HiveField(11)
  double discount;
  @HiveField(12)
  double price;

  Diamond({
    required this.lotId,
    required this.size,
    required this.carat,
    required this.lab,
    required this.shape,
    required this.color,
    required this.clarity,
    required this.cut,
    required this.polish,
    required this.symmetry,
    required this.fluorescence,
    required this.discount,
    required this.price,
  });

  factory Diamond.fromJson(Map<String, dynamic> json) {
    return Diamond(
      lotId: json['Lot ID'],
      size: json['Size'],
      carat: json['Carat'].toDouble(),
      lab: json['Lab'],
      shape: json['Shape'],
      color: json['Color'],
      clarity: json['Clarity'],
      cut: json['Cut'] ?? "EX",
      discount: double.parse(json['Discount'].toString()),
      price: json['Per Carat Rate'].toDouble(),
      polish: json['Polish'],
      fluorescence: json['Fluorescence'],
      symmetry: json['Symmetry'],
    );
  }

  static List<Diamond> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Diamond.fromJson(json)).toList();
  }

  String displayAppData() {
    return "Lot ID: $lotId | Size: $size | Carat: $carat | Lab: $lab | "
        "Shape: $shape | Color: $color | Clarity: $clarity | Cut: $cut | "
        "Polish: $polish | Symmetry: $symmetry | Fluorescence: $fluorescence | "
        "Discount: $discount% | Price: \$$price";
  }
}
