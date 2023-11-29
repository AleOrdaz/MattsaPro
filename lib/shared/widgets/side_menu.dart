import 'package:appmattsa/features/auth/presentation/providers/auth_provider.dart';
import 'package:appmattsa/features/lifting/liftings.dart';
import 'package:appmattsa/features/lifting/presentation/providers/mainlifting/liftingsprovider.dart';
import 'package:appmattsa/shared/shared.dart';
import 'package:appmattsa/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme/app_theme.dart';

class SideMenu extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends ConsumerState<SideMenu> {
  int navDrawerIndex = 0;
  Singleton singleton = Singleton();

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;

    return Drawer(
      elevation: 50.0,
      child: Container(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
        ),
        color: AppTheme.blueMattsa,
        child:  Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 30),
              child: Image.asset(
                "assets/images/logo_white.png",
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
            const Divider(color: AppTheme.grayMattsa),
            ListTile(
              onTap: () {
                setState(() {
                  singleton.nuevoLevantamineto = false;
                  ref.read(productsProvider.notifier).loadNextPage();
                  context.push('/mainlifting');
                });
              },
              title: const Text(
                "Levantamientos",
                style: TextStyle(color: AppTheme.grayMattsa,),
              ),
              trailing: const Icon(
                Icons.chrome_reader_mode,
                color: AppTheme.grayMattsa,
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  singleton.nuevoLevantamineto = false;
                  ref.watch(servicesProvider);
                  context.push('/servicelifint');
                });
              },
              title: const Text(
                "Servicios",
                style: TextStyle(color: AppTheme.grayMattsa,),
              ),
              trailing: const Icon(
                Icons.list_alt_rounded,
                color: AppTheme.grayMattsa,
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  ref.read(authProvider.notifier).logout();
                });
              },
              title: const Text(
                "Cerrar sesión",
                style: TextStyle(color: AppTheme.grayMattsa,),
              ),
              trailing: const Icon(
                Icons.exit_to_app,
                color: AppTheme.grayMattsa,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top:MediaQuery.of(context).size.height > 800 ?
                MediaQuery.of(context).size.height * 0.475 :
                MediaQuery.of(context).size.height * 0.425,
              ),
              child: ListTile(
                onTap: () {},
                title: const Text(
                  "v-1.8",
                  style: TextStyle(
                    color: AppTheme.grayMattsa,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
    /*NavigationDrawer(
      backgroundColor: AppTheme.blueMattsa,
        elevation: 10,
        selectedIndex: navDrawerIndex,
        onDestinationSelected: (value) {
          setState(() {
            navDrawerIndex = value;
          });

          // final menuItem = appMenuItems[value];
          // context.push( menuItem.link );
          widget.scaffoldKey.currentState?.closeDrawer();
        },
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Image.asset("assets/images/logo_white.png", width: MediaQuery.of(context).size.width * 0.25)
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomFilledButton(
                onPressed: () {
                  context.push('/servicelifint');
                },
                text: 'Servicios'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomFilledButton(
                onPressed: () {
                  context.push('/mainlifting');
                },
                text: 'Levantamientos'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomFilledButton(
                onPressed: () {
                  ref.read(authProvider.notifier).logout();
                },
                text: 'Cerrar sesión'),
          ),
        ]);*/
  }
}
