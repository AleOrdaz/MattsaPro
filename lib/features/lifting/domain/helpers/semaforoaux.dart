

import '../models/semaforo.dart';

class SemaforoAux {
  final int idSem;
  final Semaforo sem;
  final int quantity;
  final String nameCustomer;
  final String nameHorno;
  final String nameService;
   String? expanded;
   bool? isExpanded;
  final String name;
  final int id;

  SemaforoAux(
      {
      required this.idSem,
      this.expanded,
      this.isExpanded,
      required this.sem,
      required this.quantity,
      required this.nameCustomer,
      required this.nameHorno,
      required this.nameService}):
      name = nameService,
      id = idSem;

  factory SemaforoAux.fromJson(Map<String, dynamic> json) {
    final semafaro = Semaforo.fromJson(json['semaforo']);

    return SemaforoAux(
        idSem:json['idSemaforo'] ,
        sem: semafaro,
        quantity: json['quantity'],
        nameCustomer: json['nameCustomer'],
        nameHorno: json['nameHorno'],
        nameService:json ['nameService']);
  }

  
}
