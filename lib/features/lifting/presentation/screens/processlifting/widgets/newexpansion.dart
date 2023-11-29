import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../liftings.dart';
import 'widgets.dart';

class ExpansionCustomNew extends ConsumerStatefulWidget {
  final Color colorwords;
  final Color color;
  final Widget? bodywidget;
  final List<Clase> getlistitems; //

  final EvidenceFormState evidence;
  final EvidenceFormNotifier evidencenotifier;
  // future>

  const ExpansionCustomNew(
      {required this.getlistitems,
      required this.colorwords,
      required this.color,
      this.bodywidget,
      required this.evidence,
      required this.evidencenotifier, 
      super.key});

  @override
  ExpansionCustomNewState createState() => ExpansionCustomNewState();
}

class ExpansionCustomNewState extends ConsumerState<ExpansionCustomNew> {
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
              return InkWell(
                onTap: () {
                  setState(() {
                    ite.isExpanded = ite.isExpanded == true ? false : true;
                  });
                },
                child: ListTile(
                  title: Text(
                    ite.name,
                    style: TextStyle(
                      color: widget.colorwords,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
            body: widget.bodywidget ?? MovieSliderFul(
              evidence: widget.evidence,
              evidencenotifier:widget.evidencenotifier,
              idClase: ite.idClase,
            ),
            isExpanded: ite.isExpanded ?? false);
      }).toList(),
    );
  }
}
