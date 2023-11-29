import 'package:appmattsa/config/config.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Color containerColor;
  final String text;
  final int vista;

  RoundedContainer({required this.containerColor, required this.text, required this.vista});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.only(
          topRight: const Radius.circular(20.0),
          topLeft: const Radius.circular(20.0),
          bottomLeft: Radius.circular(vista == 1 ? 0 : 20.0),
          bottomRight: Radius.circular(vista == 1 ? 0 : 20.0),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

Widget getContainerSatus(int idStatus, int vista) {
  switch (idStatus) {
    case 1:
      return RoundedContainer(
        containerColor: AppTheme.bg_red_500, text: "Pendiente de cotizar", vista: vista,);
    case 2:
      return RoundedContainer(
        containerColor: AppTheme.bg_red_500, text: "Pendiente de cotizar", vista: vista,);
    case 3:
      return RoundedContainer(
        containerColor: AppTheme.bg_red_500, text: "Pendiente de cotizar", vista: vista,);
    case 4:
      return RoundedContainer(
        containerColor: AppTheme.bg_red_500, text: "Pendiente de cotizar", vista: vista,);
    case 5:
      return RoundedContainer(
        containerColor: AppTheme.bg_red_500, text: "Pendiente de cotizar", vista: vista,);
    case 6:
      return RoundedContainer(
        containerColor: AppTheme.bg_indigo_500, text: "Cotizada", vista: vista,);
    case 7:
      return RoundedContainer(
        containerColor: AppTheme.bg_yellow_500, text: "OT Recibida", vista: vista,);
    case 8:
      return RoundedContainer(
        containerColor: AppTheme.bg_blue_500, text: "OT en curso", vista: vista,);
    case 9:
      return RoundedContainer(
        containerColor: AppTheme.bg_green_500, text: "OT Finalizada", vista: vista,);
    case 10:
      return RoundedContainer(
        containerColor: AppTheme.bg_red_500, text: "Pendiente de cotizar", vista: vista,);
    default:
      return RoundedContainer(
        containerColor: AppTheme.bg_red_500, text: "Cancelada", vista: vista,);

    /*case 1:
      return RoundedContainer(
        containerColor: Color(0xFFBFDBFE), text: "Datos del cliente", vista: vista,);
    case 2:
      return RoundedContainer(
        containerColor: Color(0xFF93C5FD), text: "Condición actual", vista: vista,);
    case 3:
      return RoundedContainer(
        containerColor: Color(0xFF60A5FA), text: "Evidencia", vista: vista,);
    case 4:
      return RoundedContainer(
        containerColor: Color(0xFF818CF8), text: "Actividades y recomendaciones", vista: vista,);
    case 5:
      return RoundedContainer(
        containerColor: Color(0xFF6366F1), text: "Reporte PDF", vista: vista,);
    case 6:
      return RoundedContainer(
        containerColor: Color(0xFFF59E0B), text: "Cotizada", vista: vista,);
    case 7:
      return RoundedContainer(
        containerColor: Color(0xFF7C3AED), text: "PO", vista: vista,);
    case 8:
      return RoundedContainer(
        containerColor: Color(0xFF10B981), text: "OT", vista: vista,);
    case 9:
      return RoundedContainer(
        containerColor: Color(0xFFF59E0B), text: "Cotizada", vista: vista,);
    default:
      return RoundedContainer(
        containerColor: Color(0xFFF59E0B), text: "Cancelada", vista: vista,);*/
  }
}

Color hexToColor(String hexColor) {
  hexColor =
      hexColor.replaceAll('#', ''); // Elimina el caracter '#' si está presente
  int hexValue = int.parse(hexColor,
      radix: 16); // Convierte el número hexadecimal a entero
  return Color(
      hexValue); // Retorna el objeto Color correspondiente al número hexadecimal
}
