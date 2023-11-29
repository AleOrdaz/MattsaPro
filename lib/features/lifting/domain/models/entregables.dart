import 'dart:convert';

Entregable entregableFromJson(String str) => Entregable.fromJson(json.decode(str));
// String otdocumentToJson(OtDocument data) => json.encode(data.toJson());

class Entregable {
  final int id;
  final int idLifting;
  final String nombre;
  final String real_path;
  final String path;
  String? expanded;
  bool? isExpanded;

  Entregable(
      {this.expanded,
        this.isExpanded,
        required this.id,
        required this.idLifting,
        required this.nombre,
        required this.real_path,
        required this.path,
      });

  factory Entregable.fromJson(Map<String, dynamic> json) => Entregable(
    id: json["id"],
    idLifting: json["id_lifting"],
    nombre: json["cseriedocumento"].toString(),
    real_path: json["cfolio"].toString(),
    path:json["path"].toString(),
  );
}
