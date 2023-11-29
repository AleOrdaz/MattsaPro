import 'package:appmattsa/config/config.dart';
import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.blueMattsa,
      iconTheme: const IconThemeData(color: AppTheme.whiteMattsaLight),
      title: Container(
          // <--- Change here
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height *
                  0.085), // <-- play with the double number
          child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              title, style: const TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Montserrat',
            ),
            ),
          )
          ),
          //Image.asset("assets/images/mattsapro.png", fit: BoxFit.cover)),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
