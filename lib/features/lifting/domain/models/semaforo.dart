import 'dart:convert';

Semaforo semaforoFromJson(String str) => Semaforo.fromJson(json.decode(str));

String semaforoToJson(Semaforo data) => json.encode(data.toJson());

class Semaforo {
  final int idSemaforo;
  final String percentage;
  final String color;
  final String description;
  final String textcolor;
  final String name;
  final int id;

  Semaforo(
      {required this.idSemaforo,
      required this.percentage,
      required this.color,
      required this.description,
      required this.textcolor})
      : name = description,
        id = idSemaforo;

  factory Semaforo.fromJson(Map<String, dynamic> json) => Semaforo(
        idSemaforo: json["id"],
        percentage: json["percentage"].toString(),
        color: json["color"].toString(),
        description: json["description"].toString(),
        textcolor:json['text_color'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idSemaforo'] = idSemaforo;
    data['percentage'] = percentage;
    data['color'] = color;
    data['description'] = description;
    data['textcolor'] = textcolor;
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

