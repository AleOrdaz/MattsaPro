import 'dart:convert';

OtDocument otdocumentFromJson(String str) => OtDocument.fromJson(json.decode(str));

// String otdocumentToJson(OtDocument data) => json.encode(data.toJson());

class OtDocument {
  final int idOt;
  final int idLifting;
  final String cseriedocumento;
  final String cfolio;
  final String path;
  final String name;
   String? expanded;
   bool? isExpanded;
  final int? id;

  OtDocument(
      {this.expanded,
      this.isExpanded,
      required this.idOt,
      required this.idLifting,
      required this.cseriedocumento,
      required this.cfolio,
      required this.path,
      this.id=0,
      })
      : name = cseriedocumento + "-" + cfolio + " ";

  factory OtDocument.fromJson(Map<String, dynamic> json) => OtDocument(
        idOt: json["id"],
        idLifting: json["id_lifting"],
        cseriedocumento: json["cseriedocumento"].toString(),
        cfolio: json["cfolio"].toString(),
        path:json["path"].toString(),
      );

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['idClase'] = idClase;
  //   data['cvalor'] = cvalor;
  //   data['ccodigo'] = ccodigo;
  //   data['cidClasificacion'] = cidClasificacion;
  //   return data;
  // }

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
