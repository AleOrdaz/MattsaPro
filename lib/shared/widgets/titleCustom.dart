import 'package:appmattsa/config/config.dart';
import 'package:flutter/material.dart';

Widget buttonNext(String name,IconData icon, context, route,size) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      gradient: LinearGradient(
        colors: [
          AppTheme.blueMattsa,
          AppTheme.grayMattsaLight,
          AppTheme.blueMattsa,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        color: Colors
            .transparent, //Tranparentar la card para tomar el color del container
        elevation: 10, // La sombra que tiene el Card aumentará
        child: ListTile(
          title: Text(
            name,
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(icon,color: Colors.white,size:double.parse("20"), ),
        ),
      ),
    ),
  );
}



Widget buttonNextTwo(String name,IconData icon, context, route,size,void Function()? tap) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: AppTheme.blueMattsa,
      /*gradient: LinearGradient(
        colors: [
          AppTheme.blueMattsa,
          AppTheme.grayMattsaLight,
          AppTheme.blueMattsa,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),*/
    ),
    child: GestureDetector(
      onTap: tap,
      child: Card(
        color: Colors
            .transparent, //Tranparentar la card para tomar el color del container
        elevation: 10, // La sombra que tiene el Card aumentará
        child: ListTile(
          title: Text(
            name,
            style: TextStyle(color: Colors.white),
          ),
          trailing: Icon(icon,color: Colors.white,size:double.parse("20"), ),
        ),
      ),
    ),
  );
}