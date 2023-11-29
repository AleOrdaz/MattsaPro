import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static initEnviroment() async {
    await dotenv.load(fileName: ".env");
  }

  static String mattsaKey = dotenv.env['MATTSA_API_KEY'] ?? 'no hay api key';
  static String apiURL = dotenv.env['API_URL'] ?? 'no esta configurado el URL';
}
