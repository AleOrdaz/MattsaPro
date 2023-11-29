import 'dart:typed_data';

import 'features/lifting/presentation/screens/mainScreen.dart';

class Singleton {
  static Singleton? _instance;

  Singleton._internal() {
    _instance = this;
  }

  // Verifica si singleton es null, si es crea la instancia nueva y
  // si no devuelve la instancia del cache
  factory Singleton() => _instance ?? Singleton._internal();

  bool viewSubMenu = false;
  bool hideShowLoader = false;

  bool showMenuMainPage = false;

  List<UsersEmails> userEmail = [];
  List<String> userEmailSinId = [];
  List emails = [];

  bool nuevoLevantamineto = false;
  int idUser = 0;
  int timeLoader = 0;

  String pdf = '';
}