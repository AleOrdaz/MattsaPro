import 'dart:convert';

ZoneC zonecFromJson(String str) => ZoneC.fromJson(json.decode(str));

String zonecToJson(ZoneC data) => json.encode(data.toJson());

class ZoneC {
  final int idZone;
  final String namezone;

  final String name;
  final int id;

  ZoneC({required this.idZone, required this.namezone}):name=namezone,id=idZone;

  factory ZoneC.fromJson(Map<String, dynamic> json) => ZoneC(
      idZone: json["id"],
      namezone: json["cvalorclasificacion"].toString(),      
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IdCustomer'] = idZone;
    data['CodCustomer'] = namezone;

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