import 'dart:convert';

Linea LineaFromJson(String str) => Linea.fromJson(json.decode(str));

String LineaToJson(Linea data) => json.encode(data.toJson());

class Linea {
  final int idLinea;
  final String nameLinea;
  final String features;
  final int idOventype;
  final String activeOven;
  final String name;
  final int id;

  Linea(
      {required this.idLinea,
      required this.nameLinea,
      required this.features,
      required this.idOventype,
      required this.activeOven,
      }):name=nameLinea,id=idLinea;

  factory Linea.fromJson(Map<String, dynamic> json) => Linea(
        idLinea: json['id'],
        nameLinea: json['name'],
        features: json['features'],
        idOventype: json['id_oven_type'],
        activeOven: json['active'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.idLinea;
    data['name'] = this.nameLinea;
    data['features'] = this.features;
    data['id_oven_type'] = this.idOventype;
    data['active'] = this.activeOven;
    return data;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Linea &&
            other.idLinea == idLinea &&
            other.nameLinea == nameLinea &&
            other.features == features &&
            other.idOventype == idOventype);
  }
}
