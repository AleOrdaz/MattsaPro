import 'package:flutter/material.dart';

import '../../config/config.dart';

class CustomTextFormFieldReplace extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Color backgroundColor;
  final double contentPadding;
  final Color validationColor;
  final double hintFontSize;
  final Color hintColor;
  final double borderRadius;
  final Color borderErrorColor;
  final double errorBorderWidth;
  final double focusedErrorBorderWidth = 2;
  final Color borderFocusedErrorColor = Colors.redAccent;
  final Color borderColor;
  final double enabledBorderWidth = 1;
  final double borderWidth = 2;
  final Color borderFocusColor;
  final double focusedBorderWidth = 2;
  final Color textColor;
  final Color prefixIconColor;
  final bool showPrefixIcon;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final double prefixIconPaddingLeft;
  final double prefixIconPaddingRight;
  final double prefixIconPaddingTop;
  final double prefixIconPaddingBottom;
  final double fontSize;
  final String initialValue;

  const CustomTextFormFieldReplace(
      {super.key,
      this.label,
      this.hint,
      this.errorMessage,
      this.initialValue = '',
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.validator,
      this.backgroundColor = Colors.white,
      this.contentPadding = 6,
      this.validationColor = Colors.redAccent,
      this.hintFontSize = 15,
      this.hintColor = Colors.black,
      this.borderRadius = 40,
      this.borderErrorColor = Colors.redAccent,
      this.borderFocusColor = AppTheme.grayMattsaLight,
      this.borderColor = AppTheme.blueMattsa,
      this.textColor = Colors.black,
      this.prefixIconColor = Colors.redAccent,
      this.suffixIcon,
      this.showPrefixIcon = false,
      this.prefixIcon,
      this.prefixIconPaddingLeft = 30,
      this.prefixIconPaddingRight = 10,
      this.prefixIconPaddingTop = 0,
      this.prefixIconPaddingBottom = 0,
      this.fontSize = 18,
      this.errorBorderWidth = 2,
      });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    // const borderRadius = Radius.circular(15);

    return Container(
      // padding: const EdgeInsets.only(bottom: 0, top: 15),

      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
        ),
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: backgroundColor,
          contentPadding: EdgeInsets.all(contentPadding),

          // enabledBorder: border,
          // focusedBorder: border,
          // focusedErrorBorder: border.copyWith(
          //     borderSide: BorderSide(color: Colors.transparent)),
          isDense: true,
          label: label != null ? Text(label!, style: const TextStyle(fontSize: 19),) : null,
          hintText: hint,
          errorText: errorMessage,
          focusColor: colors.primary,
          errorStyle: TextStyle(
            color: validationColor,
          ),
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: hintFontSize,
            color: hintColor,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderErrorColor,
              width: errorBorderWidth,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderFocusedErrorColor,
              width: focusedErrorBorderWidth,
            ),
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
          // icon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
        ),
      ),
    );
  }
}
