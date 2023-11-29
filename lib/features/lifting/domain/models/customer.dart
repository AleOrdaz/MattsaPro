import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  final int IdCustomer;
  final String CodCustomer;
  final String RSCustomer;
  final int cidclienteproveedor;
  final String CRFC;
  final String name;
  final int id;

  Customer(
      {required this.IdCustomer,
      required this.CodCustomer,
      required this.RSCustomer,
      required this.cidclienteproveedor,
      required this.CRFC})
      : name = RSCustomer,
        id = IdCustomer;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        IdCustomer: json["id"],
        CodCustomer: json["ccodigocliente"].toString(),
        RSCustomer: json["crazonsocial"].toString(),
        CRFC: json["crfc"].toString(),
        cidclienteproveedor:json['cidclienteproveedor'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdCustomer'] = this.IdCustomer;
    data['CodCustomer'] = this.CodCustomer;
    data['RSCustomer'] = this.RSCustomer;
    data['CRFC'] = this.CRFC;
    return data;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Customer &&
            other.IdCustomer == IdCustomer &&
            other.CodCustomer == CodCustomer &&
            other.CRFC == CRFC &&
            other.RSCustomer == RSCustomer);
  }
}
