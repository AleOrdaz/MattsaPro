import 'dart:convert';

Liftingevidence liftingevidenceFromJson(String str) =>
    Liftingevidence.fromJson(json.decode(str));

String liftingevidence(Liftingevidence data) => json.encode(data.toJson());

class Liftingevidence {
  final int idLiftingevidence;
  final int idLifting;
  final String? comment;
  final int idClass;
  final String pathDocument;
  final String name;
  final int id;

  Liftingevidence(
      {required this.idLiftingevidence,
      required this.idLifting,
      this.comment,
      required this.idClass,
      required this.pathDocument})
      : name = "evidence",
        id = idLiftingevidence;

  factory Liftingevidence.fromJson(Map<String, dynamic> json) => Liftingevidence(
        idLiftingevidence: json["id"],
        idLifting: json["id_lifting"],
        comment: json["comentario"],
        idClass: json["id_class"],
        pathDocument: json['path_document'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = idLiftingevidence;
    data['id_lifting'] = idLifting;
    data['comentario'] = comment;
    data['id_class'] = idClass;
    data['path_document'] = pathDocument;
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
