import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dropdownStateProvider = ChangeNotifierProvider<DropdownState>((ref) {
  return DropdownState({});
});

class DropdownState extends ChangeNotifier {
  final Map<int, Mydata> selectedValues;

  DropdownState(this.selectedValues);
}

class Mydata {
  int index;
  Color mycolor;
  String value;
  int idClase;

  Mydata(
      {required this.index,
      required this.mycolor,
      required this.value,
      required this.idClase});
}