import 'dart:convert';

Clase claseFromJson(String str) => Clase.fromJson(json.decode(str));

String claseToJson(Clase data) => json.encode(data.toJson());

class Clase {
  final int idClase;
  final String cvalor;
  final String ccodigo;
  final String cidClasificacion;
  final String name;
   String? expanded;
   bool? isExpanded;
  final int id;

  Clase(
      {this.expanded,
      this.isExpanded,
      required this.idClase,
      required this.cvalor,
      required this.ccodigo,
      required this.cidClasificacion})
      : name = cvalor,
        id = idClase;

  factory Clase.fromJson(Map<String, dynamic> json) => Clase(
        idClase: json["id"],
        cvalor: json["name"].toString(),
        ccodigo: json["features"].toString(),
        cidClasificacion: json["features"].toString(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idClase'] = idClase;
    data['cvalor'] = cvalor;
    data['ccodigo'] = ccodigo;
    data['cidClasificacion'] = cidClasificacion;
    return data;
  }

//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType &&
//             other is Customer &&
//             other.IdCustomer == IdCustomer &&
//             other.CodCustomer == CodCustomer &&
//             other.CRFC == CRFC &&
//             other.RSCustomer == RSCustomer);
//   }
}
