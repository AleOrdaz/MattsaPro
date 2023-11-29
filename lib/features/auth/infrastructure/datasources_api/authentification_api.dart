import 'dart:async';
import 'dart:io';

import 'package:appmattsa/features/lifting/presentation/screens/serviceslifting/signaturePage.dart';

import '../../../../config/config.dart';
import '../../../../shared/helpers/http.dart';
import '../../../../shared/helpers/http_method.dart';
import '../../domain/domain.dart';
import '../../domain/models/manageauth.dart';
import '../../domain/response/login_response.dart';
import '../../domain/use_case/authentication.dart';
import '../errors/auth_errors.dart';

class AuthentificationApi extends AuthentificationUseCase {
  final Http _http = Http(baseUrl: Enviroment.apiURL);

  @override
  // TODO: implement accessToken
  Future<String?> get accessToken => throw UnimplementedError();

  @override
  Future<ManageAuth> checkAuthStatus(String token) async {
    ManageAuth manageAuth = ManageAuth(response: LoginResponse.ok);
    String errorInterno = "";
    User user = User(id: 2, email: "ddd");
    _http.typeHeader = "onlyjson";
    final result = await _http.request<String>(
      'verificar-token', //  /api/lifting/datos/cliente/insert  /api/Login
      // queryParameters: {"delay": "5"},
      method: HttpMethod.post,
      body: {
        "token": token,
        // "id_custumer": 5,
        // "id_oven": 6,
        // "id_domicilio": 7,
        // "service_type": "pruebass",
        // 'name':"jsdfnksdn",
      }, //{"email": email, "password": password}
      parser: (data) {
        if (data['res'] == true) {
          user = User.fromJson(data['msg']['usuario']);
        } else {
          errorInterno = data['msg'];
        }

        manageAuth.user = user;

        ///aqui esta se maneja el tipado de datos al momento de recibirlo.
        return data['res'].toString();
      },
    );

    // print("result data ${result.data}");
    // print("result data runtimeType ${result.data.runtimeType}");
    // print("result error data ${result.error?.exception}");
    // print("result error data ${result.error?.stackTrace}");
    // print("result statusCode ${result.statusCode}");
    if (result.error == null) {
      manageAuth.response = LoginResponse.ok;
      return manageAuth;
    }

    if (result.statusCode == 400) {
      manageAuth.response = LoginResponse.accessDenied;
      return manageAuth;
    }

    final error = result.error!.exception;
    if (error is SocketException || error is TimeoutException) {
       manageAuth.response = LoginResponse.networkError;
      return manageAuth;
    }
    manageAuth.response = LoginResponse.unknownError;
    return manageAuth;
  }

  @override
  Future<ManageAuth> login(String email, String password) async {
    ManageAuth manageAuth = ManageAuth(response: LoginResponse.ok);
    String errorInterno = "";
    User user = User(id: 2, email: "ddd");
    _http.typeHeader = "onlyjson";
    final result = await _http.request<String>(
      'acceso', //  /api/lifting/datos/cliente/insert  /api/Login
      // queryParameters: {"delay": "5"},
      method: HttpMethod.post,
      body: {
        "email": email, "password": password
        // "id_custumer": 5,
        // "id_oven": 6,
        // "id_domicilio": 7,
        // "service_type": "pruebass",
        // 'name':"jsdfnksdn",
      }, //{"email": email, "password": password}
      parser: (data) {
        print(data);
        print('----------------------------------------------------------------');
        if (data['res'] == true) {
          user = User.fromJson(data['msg']['usuario']);
        } else {
          errorInterno = data['msg'];
        }
        print(user.id);
        singleton.idUser = user.id;
        manageAuth.user = user;

        ///aqui esta se maneja el tipado de datos al momento de recibirlo.
        return data['res'].toString();
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");
    if (result.error == null) {
      manageAuth.response = LoginResponse.ok;
      return manageAuth;
    }

    if (result.statusCode == 400) {
      manageAuth.response = LoginResponse.accessDenied;
      return manageAuth;
    }

    final error = result.error!.exception;
    if (error is SocketException || error is TimeoutException) {
       manageAuth.response = LoginResponse.networkError;
      return manageAuth;
    }
    manageAuth.response = LoginResponse.unknownError;
    return manageAuth;
  }

  @override
  Future<User> loginUser(String email, String password) async {
    User user = User(id: 2, email: "ddd");
    String errorInterno = "";
    _http.typeHeader = "onlyjson";
    final result = await _http.request<String>(
      'acceso', //  /api/lifting/datos/cliente/insert  /api/Login
      // queryParameters: {"delay": "5"},
      method: HttpMethod.post,
      body: {
        "email": email, "password": password
        // "id_custumer": 5,
        // "id_oven": 6,
        // "id_domicilio": 7,
        // "service_type": "pruebass",
        // 'name':"jsdfnksdn",
      }, //{"email": email, "password": password}
      parser: (data) {
        print(data);

        if (data['res'] == true) {
          user = User.fromJson(data['msg']['usuario']);
        } else {
          errorInterno = data['msg'];
        }

        ///aqui esta se maneja el tipado de datos al momento de recibirlo.
        return data['res'].toString();
      },
    );

    print("result data ${result.data}");
    print("result data runtimeType ${result.data.runtimeType}");
    print("result error data ${result.error?.exception}");
    print("result error data ${result.error?.stackTrace}");
    print("result statusCode ${result.statusCode}");
    if (result.error == null) {
      return user;
    }

    if (result.statusCode == 400) {
      // return LoginResponse.accessDenied;
      return throw CustomError("Credenciales incorrectas", result.statusCode);
    }

    final error = result.error!.exception;
    if (error is SocketException || error is TimeoutException) {
      // return LoginResponse.networkError;

      return throw CustomError(
          "Verificar su conexion de internet", result.statusCode);
    }

    if (result.statusCode >= 500) {
      // return LoginResponse.accessDenied;
      return throw CustomError("Error del servidor", result.statusCode);
    }

    return throw CustomError("Error inesperado", result.statusCode);
  }
}
