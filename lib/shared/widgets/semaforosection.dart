import 'package:flutter/material.dart';

class SemaforoSection extends StatelessWidget {
  final String description;
  final Color color;

  const SemaforoSection({super.key, required this.description, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      subSection('Work', 'work',color, description),
    ]);
  }
}

Widget subSection(name, nameIcon, Color col, String title) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Card(
      //semanticContainer: false,
      color: col, //Tranparentar la card para tomar el color del container
      //elevation: 10, // La sombra que tiene el Card aumentará
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

 Color getColor(String value) {
    Color type;
    switch (value) {
      case "1":
        type = const Color(0xFF222222);
        break;
      case "5":
        type = const Color(0xFFa80606);
        break;
      case "6":
        type = const Color(0xFFe3b100);
        break;
      case "7":
        type = const Color(0xFF25b1ff);
        break;
      default:
        type = const Color(0xFF56bf6d);
        break;
    }
    return type;
  }