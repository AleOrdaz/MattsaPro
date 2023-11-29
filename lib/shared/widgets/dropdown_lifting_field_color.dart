import 'package:flutter/material.dart';

import '../../features/lifting/liftings.dart';
class CustomDropdownFieldColor extends StatelessWidget {
  final bool isTopField; // La idea es que tenga bordes redondeados arriba
  final bool isBottomField; // La idea es que tenga bordes redondeados abajo
  final String? label;
  final String? hint;
  final String? errorMessage;
  final List<Dropdownaux> dropdownItems;
  final String? initialValue;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  const CustomDropdownFieldColor({
    Key? key,
    this.isTopField = false,
    this.isBottomField = false,
    this.label,
    this.hint,
    this.errorMessage,
    required this.dropdownItems,
    this.initialValue,
    this.onChanged,
    this.validator,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );
    const borderRadius = Radius.circular(15);
    return Column(
      children: [
        if((dropdownItems.isNotEmpty) && (dropdownItems.isNotEmpty && initialValue!=null))
        Center(
          child: Text(
            label!,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: isTopField ? borderRadius : Radius.zero,
              topRight: isTopField ? borderRadius : Radius.zero,
              bottomLeft: isBottomField ? borderRadius : Radius.zero,
              bottomRight: isBottomField ? borderRadius : Radius.zero,
            ),
            boxShadow: [
              if (isBottomField)
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            value: initialValue=="-1"? null : initialValue,
            items: dropdownItems.map((Dropdownaux value) {
              final truncatedText = value.Texto.length > 30 ? value.Texto.substring(0, 28) + '...' : value.Texto;
              return DropdownMenuItem<String>(
                value: value.id,
                child: Container(
                  color: getColorForId(value.id),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      truncatedText,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              floatingLabelStyle:
                  const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 1),
              enabledBorder: border,
              focusedBorder: border,
              errorBorder: border.copyWith(borderSide: const BorderSide(color: Colors.transparent)),
              focusedErrorBorder:
                  border.copyWith(borderSide: const BorderSide(color: Colors.transparent)),
              isDense: true,
              label: label != null ? Text(label!) : null,
              hintText: hint,
              errorText: errorMessage,
              focusColor: colors.primary,
              labelStyle: TextStyle(
                height: 10,
              ),
   

            ),
          ),
        ),
      ],
    );
  }

  Color getColorForId(String? id) {
    // Aquí puedes definir los colores para cada opción según el ID
    switch (id) {
      case '1':
        return Colors.red;
      case '5':
        return Colors.green;
      case '6':
        return Colors.blue;
      case '7':
        return Colors.blueAccent;
      default:
        return Colors.grey;
    }
  }
}