import 'dart:ui';
import 'package:appmattsa/features/lifting/presentation/screens/processlifting/widgets/movie_slider%20copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../domain/models/clases.dart';
import '../../../providers/evidenceliftingafter/forms/evidence_form_provider.dart';
import 'widgets.dart';

class ExpansionCustomNewT extends ConsumerStatefulWidget {
  final Color colorwords;
  final Color color;
  final Widget? bodywidget;
  final List<Clase> getlistitems; //

  final EvidenceFormState evidence;
  final EvidenceFormNotifier evidencenotifier;
  // future>

  const ExpansionCustomNewT(
      {required this.getlistitems,
      required this.colorwords,
      required this.color,
      this.bodywidget,
      required this.evidence,
      required this.evidencenotifier, 
      super.key});

  @override
  ExpansionCustomNewStateT createState() => ExpansionCustomNewStateT();
}

class ExpansionCustomNewStateT extends ConsumerState<ExpansionCustomNewT> {
  List<Clase> _listitems = [];
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return CustomExpansionPanelList(
      color: widget.color,
      paddingVertical: 5,
      radioBox: 20,
      radioBigBox: 10,
      expansionCallback: (int index, bool isexpanded) {
        setState(() {
          widget.getlistitems[index].isExpanded = !isexpanded;
        });
      },
      children: widget.getlistitems.map<ExpansionPanel>((Clase ite) {
        return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(
                  ite.name,
                  style: TextStyle(color: widget.colorwords),
                ),
              );
            },
            body:
                widget.bodywidget ??  MovieSliderFult(evidence: widget.evidence,evidencenotifier:widget.evidencenotifier,idClase: ite.idClase,),
            isExpanded: ite.isExpanded ?? false);
      }).toList(),
    );
  }
}
