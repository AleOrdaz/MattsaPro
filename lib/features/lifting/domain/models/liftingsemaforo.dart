import 'dart:convert';

LiftingSemaforo liftingsemaforoFromJson(String str) => LiftingSemaforo.fromJson(json.decode(str));

String liftingsemaforoToJson(LiftingSemaforo data) => json.encode(data.toJson());

class LiftingSemaforo {
  final int idLiftingSemaforo;
  final int idLifting;
  final int idSemaforo;
  final int idClase;
  final String name;
   String? expanded;
   bool? isExpanded;
  final int id;

  LiftingSemaforo(
      {this.expanded,
      this.isExpanded,
      required this.idClase,
      required this.idLiftingSemaforo,
      required this.idLifting,
      required this.idSemaforo})
      : name = idLiftingSemaforo.toString(),
        id = idLiftingSemaforo;

  factory LiftingSemaforo.fromJson(Map<String, dynamic> json) => LiftingSemaforo(
        idLiftingSemaforo: json["id"],
        idLifting: json["id_lifting"],
        idSemaforo: json["id_semaforo"],
        idClase: json["id_class"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = idLiftingSemaforo;
    data['id_lifting'] = idLifting;
    data['id_semaforo'] = idSemaforo;
    data['id_class'] = idClase;
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
