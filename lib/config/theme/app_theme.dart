import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
const scaffoldBackgroundColor = Color.fromARGB(255, 165, 165, 165);
class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed:whiteMattsaLight,

        scaffoldBackgroundColor: scaffoldBackgroundColor,

        ///* Buttons
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              GoogleFonts.montserratAlternates()
                .copyWith(fontWeight: FontWeight.w700)
              )
          )
        ),

        ///* AppBar
        appBarTheme: AppBarTheme(
          color: scaffoldBackgroundColor,
          titleTextStyle: GoogleFonts.montserratAlternates()
            .copyWith( fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white ),
        )
      );

  static const blueMattsa = Color.fromARGB(255, 2, 24, 38);
  static const blueTransparentMattsa = Color.fromARGB(155, 2, 24, 38);
  static const redMattsa = Color.fromARGB(255, 247, 22, 53);
  static const grayMattsa = Color.fromARGB(255, 165, 165, 165);
  static const grayMattsaLight = Color.fromARGB(255, 1, 46, 73);
  static const whiteMattsaLight = Color.fromARGB(255, 255, 255, 255);

  static const bg_red_500 = Color(0xFFf56565);
  static const bg_indigo_500 = Color(0xFF667eea);
  static const bg_yellow_500 = Color(0xFFecc94b);
  static const bg_blue_500 = Color(0xFF4299e1);
  static const bg_green_500 = Color(0xFF48bb78);
}
