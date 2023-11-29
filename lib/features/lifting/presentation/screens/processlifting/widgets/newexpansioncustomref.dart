import 'dart:ui';
import 'package:appmattsa/shared/widgets/semaforosection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../config/theme/app_theme.dart';
import '../../../../domain/domain.dart';
import 'widgets.dart';

class ExpansionCustomRef extends ConsumerStatefulWidget {
  final Color colorwords;
  final Color color;
  final Widget? bodywidget;
  final List<SemaforoAuxS> getlistitems; //
  // future>

  const ExpansionCustomRef(
      {required this.getlistitems,
        required this.colorwords,
        required this.color,
        this.bodywidget,
        super.key});

  @override
  ExpansionCustomNewRefState createState() => ExpansionCustomNewRefState();
}

class ExpansionCustomNewRefState extends ConsumerState<ExpansionCustomRef> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: AppTheme.grayMattsa,
        ),
        borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
      ),
      child: Column(
      /*color: widget.color,
      paddingVertical: 5,
      radioBox: 20,
      radioBigBox: 10,
      expansionCallback: (int index, bool isexpanded) {
        setState(() {
          widget.getlistitems[index].isExpanded = !isexpanded;
        });
      },*/
      children: widget.getlistitems.map<Widget>((SemaforoAuxS ite) {
        /*return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {*/
        return  Column(
            children: [
              const  ListTile(
                  title: Text(
                    'Información General',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.blueMattsa,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ),
              _Generalwidget(
                  semaforo: widget.getlistitems[0].items,
                  datos: widget.getlistitems[0].giveinfo())
            ],
          );
        //},
        /*body: _Generalwidget(
                semaforo: widget.getlistitems[0].items,
                datos: widget.getlistitems[0].giveinfo()),
            isExpanded: ite.isExpanded ?? false);*/
      }).toList(),
        ),
    );
  }
}

// ignore: must_be_immutable
class _Generalwidget extends StatelessWidget {
  List<SemaforoAux> semaforo;
  Map<String, String> datos;
  _Generalwidget({
    super.key,
    required this.semaforo,
    required this.datos,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> listwidget = [];
    int count = 1;
    datos.forEach((key, value) {
        listwidget.add(
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: count == 1 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
        count++;
      },
    );

    final List<Widget> sublist = [];
    final int flexv = (12 / semaforo.length > 0 ? semaforo.length : 2).toInt();
    semaforo.forEach((element) {
      sublist.add(Expanded(
        flex: flexv,
        child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: SingleChildScrollView(
              child: CustomWidget(
                containerColor: getColor(element.sem.idSemaforo.toString()),
                text: element.sem.percentage,
                textColor: Colors.white,
                number: element.quantity,
              ),
            )),
      ));
    });

    final row = SingleChildScrollView(
      child: Row(
        children: sublist,
      ),
    );
    listwidget.add(row);

    return SingleChildScrollView(child:Column(children: listwidget));
  }

  Color _getColor(String value) {
    Color type;
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
        type = const Color(0xFF56bf6d);
        break;
    }
    return type;
  }
}
