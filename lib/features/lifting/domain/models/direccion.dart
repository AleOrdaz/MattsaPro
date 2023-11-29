import 'dart:convert';

Direccion direccionFromJson(String str) => Direccion.fromJson(json.decode(str));

String direccionToJson(Direccion data) => json.encode(data.toJson());

class Direccion {
  final int idDireccion;
  final String calle;
  final String numExt;
  final String numInt;
  final String colonia;
  final String cP;
  final int id;
  final String idCustomer;
  final String name;

  Direccion( 
      {
      required this.idCustomer,
      required this.idDireccion,
      required this.calle,
      required this.numExt,
      required this.numInt,
      required this.colonia,
      required this.cP})
      : name = calle + ', ' + colonia +' CP: '+cP ,
        id = idDireccion;

  factory Direccion.fromJson(Map<String, dynamic> json) => Direccion(
        idDireccion: json["id"],
        calle: json["cnombrecalle"].toString(),
        numExt: json["cnumeroexterior"].toString(),
        numInt: json["cnumerointerior"].toString(),
        colonia: json["ccolonia"].toString(),
        cP: json["ccodigopostal"].toString(),
        idCustomer: json["cidcatalogo"].toString(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    // data['IdCustomer'] = this.IdCustomer;
    // data['CodCustomer'] = this.CodCustomer;
    // data['RSCustomer'] = this.RSCustomer;
    // data['CRFC'] = this.CRFC;
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
