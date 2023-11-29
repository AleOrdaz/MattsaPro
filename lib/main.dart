import 'package:appmattsa/config/constants/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/app.dart';

Future<void> main() async {
  await Enviroment.initEnviroment();
  runApp(const ProviderScope(child: MainApp()));
}
