

import '../models/Liftingevidence.dart';
import '../models/clases.dart';
import '../models/semaforo.dart';

class NewExt {
  Semaforo sem;
  List<Clase>? myclase;
  List<Liftingevidence>? myevidence;

  NewExt({required this.sem, this.myclase, this.myevidence});

  factory NewExt.fromJson(Map<String, dynamic> json) {
    final semafaro = Semaforo.fromJson(json['semaforo']);
    final List<Clase> aux = [];

    for (int i = 0; i < json['clases'].length; i++) {
      aux.add(Clase.fromJson(json['clases'][i]));
    }
    final List<Liftingevidence> aux2 = [];
    for (int i = 0; i < json['evidence'].length; i++) {
      final pr = json['evidence'][i];
      for(int j=0;j<pr['evidences'].length;j++){
        aux2.add(Liftingevidence.fromJson(pr['evidences'][j]));
      }
    }

    return NewExt(sem: semafaro, myclase: aux, myevidence: aux2);
  }
}
