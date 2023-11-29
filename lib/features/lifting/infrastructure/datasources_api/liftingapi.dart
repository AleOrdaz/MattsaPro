import 'dart:convert';
import 'dart:io';
import 'package:appmattsa/features/lifting/domain/domain.dart';
import 'package:appmattsa/features/lifting/domain/models/entregables.dart';
import 'package:appmattsa/features/lifting/domain/models/ot.dart';

import '../../../../config/config.dart';
import '../../../../shared/helpers/helpers.dart';
import 'package:http/http.dart' as http;

class LiftingApi extends LiftingDataUseCase {
  final Http _http = Http(baseUrl: Enviroment.apiURL);
  @override
  Future<int> createSemaforo(int clase, int semaforo, int idlifting) {
    // TODO: implement createSemaforo
    throw UnimplementedError();
  }

  @override
  Future<List<Clase>> getAllClases() {
    // TODO: implement getAllClases
    throw UnimplementedError();
  }

  @override
  Future<List<NewExt>> getAllLift(int idlifting) async {
    final List<NewExt> newsemaforo = [];
    int isfallo = 0;
    bool respuesta = false;
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'lifting/all/' + idlifting.toString(),
      // queryParameters: {"delay": "5"},
      method: HttpMethod.get,
      body: {},
      parser: (data) {
        final pru = data['lifting'];
        for (var i = 0; i < pru.length; i++) {
          newsemaforo.add(NewExt.fromJson(pru[i]));
          // print(data[i]);
          // print(data[i]['IdCustomer']);
        }

        // final customer = customerFromJson(data);
        respuesta = data['res'];
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return newsemaforo;
  }

  @override
  Future<List<SemaforoAux>> getAllLiftSemaforo(int idlifting) async {
    final List<SemaforoAux> newsemaforo = [];
    int isfallo = 0;
    bool respuesta = false;
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'getsemaforo/' + idlifting.toString(),
      // queryParameters: {"delay": "5"},
      method: HttpMethod.get,
      body: {},
      parser: (data) {
        final pru = data['lifting'];
        for (var i = 0; i < pru.length; i++) {
          print(pru[i]);
          newsemaforo.add(SemaforoAux.fromJson(pru[i]));
          // print(data[i]);
          // print(data[i]['IdCustomer']);
        }

        // final customer = customerFromJson(data);
        respuesta = data['res'];
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return newsemaforo;
  }

  @override
  Future<List<Clase>> getClassSemaforo(int idlifting, int idSemaforo) {
    // TODO: implement getClassSemaforo
    throw UnimplementedError();
  }

  @override
  Future<List<Liftingevidence>> getEvidences(int idLifting, int idClass) {
    // TODO: implement getEvidences
    throw UnimplementedError();
  }

  @override
  Future<List<Lifting>> getLiftings() {
    // TODO: implement getLiftings
    throw UnimplementedError();
  }

  @override
  Future<List<Semaforo>> getSemaforoLift(int idlifting) {
    // TODO: implement getSemaforoLift
    throw UnimplementedError();
  }

  @override
  Future<List<LiftingSemaforo>> getSemaforoLiftLink(int idlifting) async {
    List<LiftingSemaforo> semaforos = [];

    int isfallo = 0;
    bool respuesta = false;
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'lifting/semaforo/clase/' + idlifting.toString(),
      // queryParameters: {"delay": "5"},
      method: HttpMethod.get,
      body: {},
      parser: (data) {
        final pru = data['lifting'];
        for (var i = 0; i < pru.length; i++) {
          semaforos.add(LiftingSemaforo.fromJson(pru[i]));
          // print(data[i]);
          // print(data[i]['IdCustomer']);
        }

        // final customer = customerFromJson(data);
        respuesta = data['res'];
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return semaforos;
  }

  @override
  Future<int> setCommentAct(int idlifting, String comentario) async {
    bool respuesta = false;

    _http.typeHeader = "jjjjbjbj";
    final result = await _http.request<dynamic>(
      'setcomment/' + idlifting.toString(),
      // queryParameters: {"delay": "5"},
      method: HttpMethod.post,
      body: {
        'comentario': comentario,
      },
      parser: (data) {
        respuesta = data['res'];
        idlifting = data['lifting'];
        // final customer = customerFromJson(data);
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    if (respuesta == true) {
      return 1;
    } else {
      return -1;
    }
  }

  @override
  Future<int> updateComentarioevidence(
      int idEvidence, String comentario) async {
    bool respuesta = false;
    int idlifting = -1;

    _http.typeHeader = "jjjjbjbj";
    final result = await _http.request<dynamic>(
      'update/evidence/' + idEvidence.toString(),
      // queryParameters: {"delay": "5"},
      method: HttpMethod.post,
      body: {
        'comentario': comentario,
      },
      parser: (data) {
        respuesta = data['res'];
        idEvidence = data['lifting'];
        // final customer = customerFromJson(data);
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    if (respuesta == true) {
      return idEvidence;
    } else {
      return -1;
    }
  }

  @override
  Future<String> uploadImage(
      File imageFile, int idLifting, int idClass, String comentario) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://mattsa.artendigital.mx/api/uploadimages'),
    );
    // Agrega la imagen al request
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
      ),
    );

    request.fields['idLifting'] = idLifting.toString();
    request.fields['idClass'] = idClass.toString();
    request.fields['comentario'] = comentario;
    // Envía el request y espera la respuesta
    var response = await request.send();

    print(response);
    // Lee la respuesta
    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      var jsonResponse = json.decode(jsonString);
      print(jsonResponse);
      String res = "OK";
      return res;
    } else {
      throw Exception('Error al subir imagen');
    }
  }

  @override
  Future<List<Lifting>> getLiftingsnextPage(
      int limit, int offset, String? token, int? idUser) async {
    List<Lifting> liftings = [];
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'liftings/by/user/$limit',
      // queryParameters: {"delay": "5"},
      method: HttpMethod.post,
      body: {'posicion': offset, 'id': idUser},
      parser: (data) {
        final pru = data['registros'];
        for (var i = 0; i < pru.length; i++) {
          // print(data[i]);
          // print(data[i]['IdCustomer']);
          var p = pru[i];
          liftings.add(Lifting.fromJson(pru[i]));
        }
        print("Mis Customers ${liftings}");
        // final customer = customerFromJson(data);
        return data['res'];
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return liftings;
  }

  @override
  Future<Lifting> getLift(int idlifting, String token, int idUser) async {
    Lifting lifting = Lifting(
        nameLifting: "nameLifting",
        idLifting: 2,
        idCustomer: 3,
        idOven: 3,
        idStatus: 3,
        idArea: 3,
        idDomicilio: 3);
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'get/lift/$idlifting',
      // queryParameters: {"delay": "5"},
      method: HttpMethod.post,
      body: {'toke': token, 'idUser': idUser},
      parser: (data) {
        final lift = data['registros'];
        print(lift);
        lifting = Lifting.fromJson(lift);

        print("Mis Customers ${lifting}");
        // final customer = customerFromJson(data);
        return data['res'];
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return lifting;
  }

  @override
  Future<List<Customer>> getAllCustomer(String token) async {
    List<Customer> customers = [];
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'custumers',
      // queryParameters: {"delay": "5"},
      method: HttpMethod.get,
      body: {},
      parser: (data) {
        final pru = data['data'];
        for (var i = 0; i < pru.length; i++) {
          // print(data[i]);
          // print(data[i]['IdCustomer']);
          customers.add(Customer.fromJson(pru[i]));
        }
        print("Mis Customers ${customers}");
        // final customer = customerFromJson(data);
        return data['res'];
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return customers;
  }

  @override
  Future<List<Oven>> getAllOvens(int id, String token) async {
    List<Oven> ovens = [];
    _http.typeHeader = "onlyjsondssdfsd";
    final result = await _http.request<dynamic>(
      'ovens/' + id.toString(),

      ///aqui concatenar si cuando se mande por get, dependiendo de quien la mande puede ser asi api/ovens/63
      //queryParameters: {"idCustomer": id.toString()}, /// utilizar este query parameters en caso de que se mande api/ovens?idcustomer=63
      method: HttpMethod.get,
      body: {},
      parser: (data) {
        var dataaux = data['data'];
        for (var i = 0; i < dataaux.length; i++) {
          print(dataaux[i]);
          // print(data[i]['IdCustomer']);
          ovens.add(Oven.fromJson(dataaux[i]));
        }
        print("Mis Customers ${ovens}");
        // final customer = customerFromJson(data);
        return data;
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return ovens;
  }

  @override
  Future<List<Service>> getAllServices(String token) async {
    List<Service> services = [];
    // List<Customer> customers = [];
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'services',
      // queryParameters: {"delay": "5"},
      method: HttpMethod.get,
      body: {},
      parser: (data) {
        final pru = data['data'];
        for (var i = 0; i < pru.length; i++) {
          // print(data[i]);
          // print(data[i]['IdCustomer']);
          services.add(Service.fromJson(pru[i]));
        }
        print("Mis Customers ${services}");
        // final customer = customerFromJson(data);
        return data['res'];
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return services;
  }

  @override
  Future<List<Customer>> getCustomerZone(int idZone, String zone) async {
    List<Customer> customers = [];
    if (idZone != -1) {
      _http.typeHeader = "ggrrrrt";
      final result = await _http.request<dynamic>(
        'custumers/zones/' + idZone.toString(),
        // queryParameters: {"delay": "5"},
        method: HttpMethod.get,
        body: {},
        parser: (data) {
          final pru = data['data'];
          for (var i = 0; i < pru.length; i++) {
            // print(data[i]);
            // print(data[i]['IdCustomer']);
            customers.add(Customer.fromJson(pru[i]));
          }
          print("Mis Customers ${customers}");
          // final customer = customerFromJson(data);
          return data['res'];
        },
      );

      print("result data ${result.data}");
      print("result data runtimeType ${result.data.runtimeType}");
      print("result error data ${result.error?.exception}");
      print("result error data ${result.error?.stackTrace}");
      print("result statusCode ${result.statusCode}");
    }
    return customers;
  }

  @override
  Future<List<Direccion>> getDirection(int idCustomer, String token) async {
    List<Direccion> direcciones = [];
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'addresses/' + idCustomer.toString(),
      // queryParameters: {"delay": "5"},
      method: HttpMethod.get,
      body: {},
      parser: (data) {
        final pru = data['data'];
        for (var i = 0; i < pru.length; i++) {
          // print(data[i]);
          // print(data[i]['IdCustomer']);
          direcciones.add(Direccion.fromJson(pru[i]));
        }
        // print("Mis Customers ${customers}");
        // final customer = customerFromJson(data);
        return data['res'];
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return direcciones;
  }

  @override
  Future<List<ZoneC>> getZones(String token) async {
    List<ZoneC> zones = [];
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'zones',
      // queryParameters: {"delay": "5"},
      method: HttpMethod.get,
      body: {},
      parser: (data) {
        final pru = data['data'];
        for (var i = 0; i < pru.length; i++) {
          // print(data[i]);
          // print(data[i]['IdCustomer']);
          zones.add(ZoneC.fromJson(pru[i]));
        }
        print("Mis Customers ${zones}");
        // final customer = customerFromJson(data);
        return data['res'];
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return zones;
  }

  @override
  Future<String> gettypeoven(int id, String token) {
    // TODO: implement gettypeoven
    throw UnimplementedError();
  }

  @override
  Future<Lifting> createUpdateProduct(Map<String, dynamic> productLike) async {
    final String? idLifting = productLike['id'];
    final HttpMethod method =
        (idLifting == null) ? HttpMethod.post : HttpMethod.put;

    final String url = (idLifting == null)
        ? 'lifting/datos/cliente/insert'
        : 'lifting/datos/cliente/$idLifting';

    productLike.remove('id');

    Lifting lifting = Lifting(
        nameLifting: "nameLifting",
        idLifting: 2,
        idCustomer: 3,
        idOven: 3,
        idStatus: 3,
        idArea: 3,
        idDomicilio: 3);
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      url,
      // queryParameters: {"delay": "5"},
      method: method,
      body: productLike,
      parser: (data) {
        final lift = data['lifting'];

        lifting = Lifting.fromJson(lift);

        // print("Mis Customers ${lifting}");
        // final customer = customerFromJson(data);
        return data['res'];
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return lifting;
  }

  @override
  Future<List<Clase>> getClasesOven(int idOven, String token) async {
    List<Clase> clases = [];
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'clases/Oven/' + idOven.toString(),
      // queryParameters: {"delay": "5"},
      method: HttpMethod.get,
      body: {},
      parser: (data) {
        final pru = data['data'];
        for (var i = 0; i < pru.length; i++) {
          // print(data[i]);
          // print(data[i]['IdCustomer']);
          clases.add(Clase.fromJson(pru[i]));
        }
        print("Mis Customers ${clases}");
        // final customer = customerFromJson(data);
        return data['res'];
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return clases;
  }

  @override
  Future<List<Semaforo>> getSemaforo(String token) async {
    List<Semaforo> semaforos = [];

    int isfallo = 0;
    bool respuesta = false;
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'semaforo',
      // queryParameters: {"delay": "5"},
      method: HttpMethod.get,
      body: {},
      parser: (data) {
        final pru = data['lifting'];
        for (var i = 0; i < pru.length; i++) {
          semaforos.add(Semaforo.fromJson(pru[i]));
          // print(data[i]);
          // print(data[i]['IdCustomer']);
        }

        // final customer = customerFromJson(data);
        respuesta = data['res'];
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return semaforos;
  }

  @override
  Future<bool> createUpdateStatus(
      Map<String, dynamic> statusLike, String token) async {
    const HttpMethod method = HttpMethod.post;

    const String url = 'lifting/status/semaforo';

    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      url,
      // queryParameters: {"delay": "5"},
      method: method,
      body: statusLike,
      parser: (data) {
        final lift = data['lifting'];

        // lifting = Lifting.fromJson(lift);

        // print("Mis Customers ${lifting}");
        // final customer = customerFromJson(data);
        return data['res'];
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return true;
  }

  @override
  Future<List<Lifting>> getServicesnextPage(
      int limit, int offset, String? token, int? idUser) async {
    List<Lifting> liftings = [];
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'services/by/user/$limit',
      // queryParameters: {"delay": "5"},
      method: HttpMethod.post,
      body: {'posicion': offset, 'id': idUser},
      parser: (data) {
        final pru = data['registros'];
        for (var i = 0; i < pru.length; i++) {
          // print(data[i]);
          // print(data[i]['IdCustomer']);
          var p = pru[i];
          liftings.add(Lifting.fromJson(pru[i]));
        }
        print("Mis Customers ${liftings}");
        // final customer = customerFromJson(data);
        return data['res'];
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return liftings;
  }

  @override
  Future<List<OtDocument>> getDocumentot(int liftingid) async {
    final List<OtDocument> newsemaforo = [];
    int isfallo = 0;
    bool respuesta = false;
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'services/stepone/' + liftingid.toString(),
      // queryParameters: {"delay": "5"},
      method: HttpMethod.get,
      body: {},
      parser: (data) {
        final pru = data['data'];
        for (var i = 0; i < pru.length; i++) {

          newsemaforo.add(OtDocument.fromJson(pru[i]));
          // print(data[i]);
          // print(data[i]['IdCustomer']);
        }

        // final customer = customerFromJson(data);
        respuesta = data['res'];
        print(data['res']);
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return newsemaforo;
  }

  @override
  Future<List<NewExt>> getAllLiftAfter(int idlifting) async {
    final List<NewExt> newsemaforo = [];
    int isfallo = 0;
    bool respuesta = false;
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'lifting/all/after/' + idlifting.toString(),
      // queryParameters: {"delay": "5"},
      method: HttpMethod.get,
      body: {},
      parser: (data) {
        final pru = data['lifting'];
        for (var i = 0; i < pru.length; i++) {
          newsemaforo.add(NewExt.fromJson(pru[i]));
          // print(data[i]);
          // print(data[i]['IdCustomer']);
        }

        // final customer = customerFromJson(data);
        respuesta = data['res'];
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return newsemaforo;
  }

  @override
  Future<String> uploadImageafter(
      File imageFile, int idLifting, int idClass, String comentario) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://mattsa.artendigital.mx/api/uploadimages/after'),
    );
    // Agrega la imagen al request
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
      ),
    );

    request.fields['idLifting'] = idLifting.toString();
    request.fields['idClass'] = idClass.toString();
    request.fields['comentario'] = comentario;
    // Envía el request y espera la respuesta
    var response = await request.send();

    print(response);
    // Lee la respuesta
    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      var jsonResponse = json.decode(jsonString);
      print(jsonResponse);
      String res = "OK";
      return res;
    } else {
      throw Exception('Error al subir imagen');
    }
  }

  @override
  Future<List<Linea>> getOvenparts(int idOven) async {
    final List<Linea> newsemaforo = [];
    int isfallo = 0;
    bool respuesta = false;
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'get/overparts/' + idOven.toString(),
      // queryParameters: {"delay": "5"},
      method: HttpMethod.get,
      body: {},
      parser: (data) {
        final pru = data['lifting'];
        for (var i = 0; i < pru.length; i++) {
          newsemaforo.add(Linea.fromJson(pru[i]));
          // print(data[i]);
          // print(data[i]['IdCustomer']);
        }

        // final customer = customerFromJson(data);
        respuesta = data['res'];
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return newsemaforo;
  }

  @override
  Future<List<OtDocument>> getDocumentremision(int liftingid) async {
    final List<OtDocument> newsemaforo = [];
    int isfallo = 0;
    bool respuesta = false;
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'services/stepone/remision/' + liftingid.toString(),
      // queryParameters: {"delay": "5"},
      method: HttpMethod.get,
      body: {},
      parser: (data) {
        final pru = data['data'];
        for (var i = 0; i < pru.length; i++) {
          newsemaforo.add(OtDocument.fromJson(pru[i]));
          // print(data[i]);
          // print(data[i]['IdCustomer']);
        }

        // final customer = customerFromJson(data);
        respuesta = data['res'];
        print(respuesta);
      },
    );
    print("result data ${respuesta}");
    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return newsemaforo;
  }

  @override
  Future<List<Entregable>> getEntregables(int liftingid) async {
    final List<Entregable> newsemaforo = [];
    int isfallo = 0;
    bool respuesta = false;
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'services/deliveries/' + liftingid.toString(),
      // queryParameters: {"delay": "5"},
      method: HttpMethod.get,
      body: {},
      parser: (data) {
        final pru = data['data'];
        for (var i = 0; i < pru.length; i++) {
          newsemaforo.add(Entregable.fromJson(pru[i]));
          // print(data[i]);
          // print(data[i]['IdCustomer']);
        }

        // final customer = customerFromJson(data);
        respuesta = data['res'];
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");

    return newsemaforo;
  }

  @override
  Future<bool> updatestate(int idlifting, String token, int idUser) async {
    bool res = false;
    Lifting lifting = Lifting(
        nameLifting: "nameLifting",
        idLifting: 2,
        idCustomer: 3,
        idOven: 3,
        idStatus: 3,
        idArea: 3,
        idDomicilio: 3);
    _http.typeHeader = "ggrrrrt";
    final result = await _http.request<dynamic>(
      'update/state/evidence/$idlifting',
      // queryParameters: {"delay": "5"},
      method: HttpMethod.get,
      body: {'toke': token, 'idUser': idUser},
      parser: (data) {
        res = data['res'];
        // final lift = data['registros'];

        // lifting = Lifting.fromJson(lift);

        // print("Mis Customers ${lifting}");
        // final customer = customerFromJson(data);
        return data['res'];
      },
    );

    // print("result data ${result.data}");
    // print("result data runtimeType ${result.data.runtimeType}");
    // print("result error data ${result.error?.exception}");
    // print("result error data ${result.error?.stackTrace}");
    // print("result statusCode ${result.statusCode}");

    return res;
  }
}
