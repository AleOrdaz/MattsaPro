import 'package:flutter/material.dart';

import 'package:appmattsa/config/router/app_router.dart';
import 'package:appmattsa/config/theme/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main(List<String> args) {
  runApp(const MainApp());
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  initState() {
    //Para mantener en una sola dirección la pantalla
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter=ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: appRouter.first,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
