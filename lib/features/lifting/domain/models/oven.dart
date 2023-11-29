import 'dart:convert';

Oven ovenFromJson(String str) => Oven.fromJson(json.decode(str));

String ovenToJson(Oven data) => json.encode(data.toJson());

class Oven {
  final int idOven;
  final String nameOven;
  final String descripcionOven;
  final String numrefOven;
  final String? nameType;
  final int idtypeOven;
  final int idlineOven;
  final String activeOven;
  final String name;
  final int id;

  Oven(
      {required this.idOven,
      required this.nameOven,
      required this.descripcionOven,
      required this.numrefOven,
      required this.idtypeOven,
      required this.idlineOven,
      required this.activeOven,
      this.nameType,
      }):name=nameOven,id=idOven;

  factory Oven.fromJson(Map<String, dynamic> json) => Oven(
        idOven: json['id'],
        nameOven: json['name'],
        descripcionOven: json['description'] ?? '',
        numrefOven: json['num_ref'],
        idtypeOven: json['id_oven_type'] ?? "-1",
        idlineOven: json['id_line'] ?? 0,
        activeOven: json['active'],
        nameType: json['name_type'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idOven'] = this.idOven;
    data['nameOven'] = this.nameOven;
    data['descripcionOven'] = this.descripcionOven;
    data['numrefOven'] = this.numrefOven;
    data['idtypeOven'] = this.idtypeOven;
    data['idlineOven'] = this.idlineOven;
    data['idlineOven'] = this.idlineOven;
    data['activeOven'] = this.activeOven;
    return data;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Oven &&
            other.idOven == idOven &&
            other.nameOven == nameOven &&
            other.descripcionOven == descripcionOven &&
            other.numrefOven == numrefOven);
  }
}
