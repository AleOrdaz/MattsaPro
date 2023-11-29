import 'dart:convert';

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
  final int idService;
  final String nameservice;
  final String name;
  final int id;

  Service(
      {
      required this.idService,
      required this.nameservice}):name=nameservice,id=idService;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
      idService: json["id"],
      nameservice: json["name"].toString(),    
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idService'] = idService;
    data['nameservice'] = nameservice;
    return data;
  }

  // @override
  // bool operator ==(Object other) {
  //   return identical(this, other) ||
  //       (other.runtimeType == runtimeType &&
  //           other is Customer &&
  //           other.IdCustomer == IdCustomer &&
  //           other.CodCustomer == CodCustomer &&
  //           other.CRFC == CRFC &&
  //           other.RSCustomer == RSCustomer);
  // }
}
