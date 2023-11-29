import 'package:appmattsa/features/lifting/domain/helpers/semaforoaux.dart';

class SemaforoAuxS {
  final int idSem;
  final String nameServ;
  final List<SemaforoAux> items;
  String? expanded;
  bool? isExpanded;
  final String name;
  final int id;
  final String fecha;

  SemaforoAuxS(
      {required this.idSem,
        this.expanded,
        this.isExpanded,
        required this.nameServ,
        required this.items,
        required this.fecha})
      : name = nameServ,
        id = idSem;

  Map<String, String> giveinfo() {

    if (items.isNotEmpty) {
      return <String, String>{'namecustomer': items[0].nameCustomer,
        'nameservice': items[0].nameService,'namehorno': items[0].nameHorno,
        'fecha': 'Fecha de actualización: $fecha'};
    }
    return <String, String>{'namecustomer': "sin datos",
      'nameservice': "sin datos",'namehorno':"sin datos"};
  }
}