import 'package:flutter/material.dart';

import '../../config/theme/app_theme.dart';

class CustomFilledButton extends StatelessWidget {

  final void Function()? onPressed;
  final String text;
  final Color? buttonColor;

  const CustomFilledButton({
    super.key, 
    this.onPressed, 
    required this.text, 
    this.buttonColor
  });

  @override
  Widget build(BuildContext context) {

    const radius = Radius.circular(15);

    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: AppTheme.grayMattsa,
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: radius,
          bottomRight: radius,
          topLeft: radius,
          topRight: radius
        )
      )),
      onPressed: onPressed, 
      child: Text(text)
    );
  }
}