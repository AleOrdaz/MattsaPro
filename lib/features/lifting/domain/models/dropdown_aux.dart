import '../../liftings.dart';

class Dropdownaux {
  final String Texto;
  final String id;

  Dropdownaux({required this.Texto, required this.id});
}

List<Dropdownaux> getzones(List<ZoneC> list) {
    List<Dropdownaux> auz = [];

    for (int i = 0; i < list.length; i++) {
      final v =
          Dropdownaux(Texto: list[i].namezone, id: list[i].idZone.toString());
      auz.add(v);
    }

    return auz;
  }


List<Dropdownaux> getcustomers(List<Customer> list) {
    List<Dropdownaux> auz = [];

    for (int i = 0; i < list.length; i++) {
      final v =
          Dropdownaux(Texto: list[i].name, id: list[i].cidclienteproveedor.toString());
      auz.add(v);
    }

    return auz;
  }

  List<Dropdownaux> getovens(List<Oven> list) {
    List<Dropdownaux> auz = [];

    for (int i = 0; i < list.length; i++) {
      print(list[i].numrefOven);
      print('list[i]');
      final v =
          Dropdownaux(Texto: '${list[i].nameOven} - Num. ${list[i].numrefOven}', id: list[i].idOven.toString());
      auz.add(v);
    }

    return auz;
  }

  List<Dropdownaux> getdirection(List<Direccion> list) {
    List<Dropdownaux> auz = [];

    for (int i = 0; i < list.length; i++) {
      final v =
          Dropdownaux(Texto: '${list[i].calle}, ${list[i].numExt}, '
              '${list[i].colonia}', id: list[i].idDireccion.toString());
      auz.add(v);
    }

    return auz;
  }

   List<Dropdownaux> getservices(List<Service> list) {
    List<Dropdownaux> auz = [];

    for (int i = 0; i < list.length; i++) {
      final v =
          Dropdownaux(Texto: list[i].nameservice, id: list[i].idService.toString());
      auz.add(v);
    }

    return auz;
  }


List<Dropdownaux> getsemaforo(List<Semaforo> list) {
    List<Dropdownaux> auz = [];

    for (int i = 0; i < list.length; i++) {
      final v =
          Dropdownaux(Texto: list[i].name+list[i].percentage, id: list[i].idSemaforo.toString());
      auz.add(v);
    }

    return auz;
  }

List<Dropdownaux> getparts(List<Linea> list) {
    List<Dropdownaux> auz = [];

    for (int i = 0; i < list.length; i++) {
      final v =
          Dropdownaux(Texto: list[i].nameLinea, id:list[i].idLinea.toString());
      auz.add(v);
    }

    return auz;
  }


