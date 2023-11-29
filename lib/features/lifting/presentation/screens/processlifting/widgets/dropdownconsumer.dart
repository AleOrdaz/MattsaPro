import 'package:appmattsa/config/theme/app_theme.dart';
import 'package:appmattsa/features/lifting/presentation/providers/statuslifting/dropdown_provider.dart';
import 'package:appmattsa/features/lifting/presentation/providers/statuslifting/forms/status_form_provider.dart';
import 'package:appmattsa/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../serviceslifting/signaturePage.dart';

class DropdownConsumer extends ConsumerStatefulWidget {
  Singleton singleton = Singleton();
  final String name;
  final int index;
  final int idClase;
  final String? errorMessage;
  final StatusFormNotifier statusfromstate;
  DropdownConsumer(
      {super.key,
      required this.statusfromstate,
      this.errorMessage,
      required this.index,
      this.name = "sin seleccionr",
      required this.idClase});

  @override
  DropdownConsumerState createState() => DropdownConsumerState();
}

class DropdownConsumerState extends ConsumerState<DropdownConsumer> {
  List<String> list = <String>['1', '5', '6', '7', '8'];
  Color yourcolor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  widget.name,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              )
          ),
          Expanded(
            flex: 7,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    
                    color: ref
                        .watch(dropdownStateProvider)
                        .selectedValues[widget.index]
                        ?.mycolor,
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: singleton.nuevoLevantamineto ? null : ref
                        .watch(dropdownStateProvider)
                        .selectedValues[widget.index]
                        ?.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    dropdownColor: Colors.grey[200],
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    elevation: 0,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      hintStyle: const TextStyle(color: Colors.black),
                      hintText: "Sin seleccionar",
                      errorText: widget.errorMessage,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        if (value != null) {
                          yourcolor = AppTheme.whiteMattsaLight; //_getColor(value, yourcolor);
                          Mydata mydata = Mydata(
                              index: widget.index,
                              mycolor: yourcolor,
                              idClase: widget.idClase,
                              value: value);
                          ref
                              .read(dropdownStateProvider)
                              .selectedValues[widget.index] = mydata;
                          widget.statusfromstate.changestatus();
                        }
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: _getValueDrop(value),
                      );
                    }).toList(),
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget _getValueDrop(
    String value,
  ) {
    Widget conten;
    switch (value) {
      case "1":
        conten = const Text(
          "0% (NO FUNCIONAL)",
          style: TextStyle(color: Color(0xFF222222)),
        );

        break;
      case "5":
        conten = Container(
          child: const Text("25% (PUEDE FALLAR)",
              style: TextStyle(color: Color(0xFFa80606))),
        );
        break;
      case "6":
        conten = Container(
          child: const Text("50% (FUNCIONAl)",
              style: TextStyle(color: Color(0xFFe3b100))),
        );
        break;
      case "7":
        conten = Container(
          child: const Text("75% (PRESENTA FALLAS",
              style: TextStyle(color: Color(0xFF25b1ff))),
        );
        break;
      default:
        conten = Container(
          child: const Text("100% (OPTIMO)",
              style: TextStyle(color: Color(0xFF059669))),
        );
        break;
    }
    return conten;
  }

  Color _getColor(String value, Color type) {
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
        type = const Color(0xFF059669);
        break;
    }

    return type;
  }
}
