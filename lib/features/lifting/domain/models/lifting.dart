import 'dart:convert';

Lifting liftingFromJson(String str) => Lifting.fromJson(json.decode(str));

String liftingToJson(Lifting data) => json.encode(data.toJson());

class Lifting {
  final String nameLifting;
  final String? namecustomer;
  final int idLifting;
  final int idCustomer;
  final int idOven;
  final int idStatus;
  final int idArea;
  final int idDomicilio;
  final int? idPart;
  final int? idProyecto;
  final int? idService;
  final String? pathDocumentPdf;
  final String name;
  final String? description;
  final String? fechaUpdate;
  final int id;

  Lifting({
    required this.nameLifting,
    required this.idLifting,
    required this.idCustomer,
    required this.idOven,
    required this.idStatus,
    required this.idArea,
    required this.idDomicilio,
    this.idPart,
    this.namecustomer,
    this.idProyecto,
    this.idService,
    this.pathDocumentPdf,
    this.description,
    this.fechaUpdate,
  })  : name = "evidence",
        id = idLifting;

  factory Lifting.fromJson(Map<String, dynamic> json) => Lifting(
        idLifting: json["id"],
        idCustomer: json["id_custumer"],
        idOven: json["id_oven"],
        idStatus: json["id_lifting_status"],
        idArea: json['id_area'],
        idDomicilio: json['id_domicilio'],
        idProyecto: json['id_proyecto'],
        idService: json['service_type'],
        nameLifting: json['name'],
        pathDocumentPdf: json['path_pdf'],
        namecustomer: json['namecustomer'],
        description: json['description'],
        fechaUpdate: json['updated_at'] ?? '',
        idPart: json['id_line'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = idLifting;
    data['id_customer'] = idCustomer;
    data['id_oven'] = idOven;
    data['id_status_lifting'] = idStatus;
    data['id_area'] = idArea;
    data['id_domicilio'] = idDomicilio;
    data['id_proyecto'] = idProyecto;
    data['service_type'] = idService;
    data['name'] = nameLifting;
    data['path_pdf'] = pathDocumentPdf;
    data['namecustomer'] = namecustomer;
    data['description'] = description;
    data['updated_at'] = fechaUpdate;
    data['id_line'] = idPart;
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
