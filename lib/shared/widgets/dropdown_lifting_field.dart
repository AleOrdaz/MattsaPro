import 'package:appmattsa/config/config.dart';
import 'package:flutter/material.dart';

import '../../features/lifting/liftings.dart';

class CustomDropdownField extends StatelessWidget {
  final bool isTopField; // La idea es que tenga bordes redondeados arriba
  final bool isBottomField; // La idea es que tenga bordes redondeados abajo
  final String? label;
  final String? hint;
  final String? errorMessage;
  final List<Dropdownaux> dropdownItems;
  final String? initialValue;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final Color borderColor;
  final double borderRadius;

  final double enabledBorderWidth;

  final Color hintColor;
  final double borderWidth;
  final double focusedBorderWidth;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
  final bool showPrefixIcon;
  final Color prefixIconColor;
  final double prefixIconPaddingLeft;
  final double prefixIconPaddingRight;
  final double prefixIconPaddingTop;
  final double prefixIconPaddingBottom;
  final Color borderFocusColor;
  final double hintFontSize;
  final Color validationColor;
  final double contentPadding;
  final int valor;
  const CustomDropdownField({
    Key? key,
    this.contentPadding = 6,
    this.showPrefixIcon = false,
    this.validationColor = Colors.redAccent,
    this.hintFontSize = 15,
    this.borderFocusColor = AppTheme.grayMattsaLight,
    this.prefixIconPaddingBottom = 0,
    this.prefixIconPaddingLeft = 30,
    this.prefixIconPaddingRight = 10,
    this.prefixIconPaddingTop = 0,
    this.suffixIcon,
    this.prefixIcon,
    this.borderColor = AppTheme.blueMattsa,
    this.prefixIconColor = Colors.redAccent,
    this.borderWidth = 8,
    this.borderRadius = 8,
    this.focusedBorderWidth = 2,
    this.hintColor = Colors.black,
    this.enabledBorderWidth = 1,
    this.isTopField = false,
    this.isBottomField = false,
    this.label,
    this.hint,
    this.errorMessage,
    required this.dropdownItems,
    this.initialValue,
    this.onChanged,
    this.validator,
    required this.valor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );
    // const borderRadius = Radius.circular(15);
    return Column(
      children: [
        // if ((dropdownItems.isNotEmpty) &&
        //     (dropdownItems.isNotEmpty && initialValue != null))
        //   Center(
        //     child: Text(
        //       label!,
        //       style: const TextStyle(
        //         color: Colors.black,
        //         fontWeight: FontWeight.bold,
        //         fontSize: 15,
        //       ),
        //     ),
        //   ),
        DropdownButtonFormField<String>(
          value: initialValue == "-1" ? null : initialValue,
          items: dropdownItems.map((Dropdownaux value) {
            final truncatedText = value.Texto.length > valor
                ? '${value.Texto.substring(0, valor+1)}...' : value.Texto;
            return DropdownMenuItem<String>(
              value: value.id,
              child: Text(truncatedText),
            );
          }).toList(),
          
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            fillColor: Colors.white,
            
            // enabledBorder: border,
            // focusedBorder: border,
        
            isDense: true,
            label:    Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(label!),
            ),
            hintText: hint,
            errorText: errorMessage,
            focusColor: colors.primary,
            labelStyle: TextStyle(
              fontSize: 18,
              height: 10,
            ),
            contentPadding: EdgeInsets.all(contentPadding),
            errorStyle: TextStyle(
              color: validationColor,
            ),
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: hintFontSize,
              color: hintColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: borderColor,
                width: enabledBorderWidth,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: borderColor,
                width: borderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderFocusColor,
                width: focusedBorderWidth,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            suffixIcon: suffixIcon,
            prefixIcon: showPrefixIcon
                ? Padding(
                    child: IconTheme(
                      data: IconThemeData(color: prefixIconColor),
                      child: prefixIcon!,
                    ),
                    padding: EdgeInsets.only(
                      left: prefixIconPaddingLeft,
                      right: prefixIconPaddingRight,
                      top: prefixIconPaddingTop,
                      bottom: prefixIconPaddingBottom,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
