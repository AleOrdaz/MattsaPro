import 'dart:convert';

import 'package:appmattsa/config/config.dart';
import 'package:appmattsa/features/lifting/presentation/screens/serviceslifting/pdfFinalView.dart';
import 'package:appmattsa/features/lifting/presentation/screens/serviceslifting/signaturePage.dart';
import 'package:appmattsa/features/lifting/presentation/screens/serviceslifting/webViewReporte.dart';
import 'package:appmattsa/features/lifting/presentation/screens/serviceslifting/widgets/cardot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../../../../../shared/shared.dart';
import '../../../liftings.dart';
import '../processlifting/widgets/widgets.dart';

class PanelGeneralSevices extends ConsumerWidget {
  final String liftingId;
  static const name = "panel_general_services";
  const PanelGeneralSevices({super.key, required this.liftingId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final panelState = ref.watch(panelProvider(liftingId));
    return Scaffold(
      backgroundColor: AppTheme.whiteMattsaLight,
      appBar: CustomAppBar(title: "Servicios",),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      body: panelState.isLoading
          ? const FullScreenLoading()
          : _PanelView(lifting: panelState.lifting!),
    );
  }
}

class _PanelView extends ConsumerStatefulWidget {
  final Lifting lifting;
  const _PanelView({required this.lifting});

  @override
  PanelViewState createState() => PanelViewState();
}

class PanelViewState extends ConsumerState<_PanelView> {
  String url = '';

  @override
  Widget build(BuildContext context) {
    final panelForm = ref.watch(panelFormProvider(widget.lifting));
    bool band = false;

    return panelForm.isloading ? const FullScreenLoading() :
    Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: ExpansionCustomRef(
                color: Colors.white,
                colorwords: Colors.black,
                getlistitems: [
                  SemaforoAuxS(
                    idSem: 1, items: panelForm.informacion, nameServ: 'prueba',
                    fecha: widget.lifting.fechaUpdate! ?? ''
                  )
                ],
                bodywidget: const Text(""),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: ExpandableCard(
                title: "O.T.",
                body: CardoT(ot: panelForm.documentOt!, val: 0,),
                data: Icons.description_rounded,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: ExpandableCard(
                title: "Remisiones",
                body: CardoT(ot: panelForm.documentremision!, val: 1),
                data: Icons.description_rounded,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: ExpandableCard(
                title: "Entregables",
                body: CardEntregable(entregables: panelForm.entregables!, val: 1),
                data: Icons.description_rounded,
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                context.push('/lifting/evidence/after/${widget.lifting.idLifting}');
              },
              child: const Text(
                "Revisión después del levantamiento",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20,),
            widget.lifting.idStatus == 9 ? ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppTheme.blueMattsa),
              ),
              onPressed: () {
                //context.push('/lifting/evidence/after/${lifting.idLifting}');
                //Navigator.push(context, MaterialPageRoute(builder:
                  //  (context) => webViewReport(id: lifting.idLifting.toString())));
                //https://mattsa.artendigital.mx/api/services/final/report/view/357
                viewReport(context, widget.lifting.idLifting.toString(), ref);
                showSnackBar(
                    context, "Cargando...", "Espere hasta que carge el documento", 1);
              },
              child: const Text(
                " Ver Reporte ",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.whiteMattsaLight,
                ),
              ),
            ) :
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppTheme.blueMattsa),
              ),
              onPressed: () {
                //context.push('/lifting/evidence/after/${lifting.idLifting}');
                singleton.hideShowLoader = false;
                createReport(context, widget.lifting.idLifting.toString(), ref);
                print(band);
                showSnackBar(
                    context, "Cargando...", "Espere hasta que genere el reporte, "
                    "esto puede tardar.", 1);
              },
              child: const Text(
                " Generar Reporte ",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.whiteMattsaLight,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: band ? const FullScreenLoading() : Container(),
            )
          ],
        ),
      ),
    );
  }

  Future<String> viewReport(BuildContext context, String idLift, WidgetRef ref) async {
    var url = 'https://mattsa.artendigital.mx/api/services/final/report/view/$idLift';
    var response = await http.get(Uri.parse(url));
    print(url);
    print(response.body);

    if(!response.body.contains("<!doctype html>")) {
      if (response.body.contains("true")) {

        print('=======TOKEN=========');
        var error = jsonDecode(response.body);
        print(error['data']);
        singleton.timeLoader = 15;
        url = error['data'];
        ref.read(selecteddocument.notifier).update(
                  (state) => error['data']);
         Navigator.push(context, MaterialPageRoute(
             builder: (context) => PdfFinalview()));
        return 'true';
      }
      else {
        print("error en la consulta");
        var error = jsonDecode(response.body);
        print(error['error']['code']);
        showSnackBar(
            context, "Error", "No se pudo cargar", 2);
        return "false";
      }
    } else {
      showSnackBar(
          context, "Error", "No se pudo cargar", 2);
      return "(error['error']['code'])";
    }
  }

  Future<String> createReport(BuildContext context, String idLift, WidgetRef ref) async {
    var url = 'https://mattsa.artendigital.mx/api/services/final/report/$idLift';
    var response = await http.get(Uri.parse(url));
    print(url);
    print(response.body);

    if(!response.body.contains("<!doctype html>")) {
      if (response.body.contains("true")) {

        print('=======TOKEN=========');
        var error = jsonDecode(response.body);
        print(error['data']);

        viewReport(context, idLift, ref);

        return 'true';
      }
      else {
        print("error en la consulta");
        var error = jsonDecode(response.body);
        print(error['error']['code']);
        showSnackBar(
            context, "Error", "No se pudo crear", 2);
        return "false";
      }
    } else {
      showSnackBar(
          context, "Error", "No se pudo crear", 2);
      return "(error['error']['code'])";
    }
  }

  void showSnackBar(BuildContext context, String titulo, String contenido, int a) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 80,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Icon(
                  a == 1
                      ? Icons.check_circle_outline_outlined
                      : Icons.close_outlined,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      titulo,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Text(
                        contenido,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          left: 20,
          bottom: MediaQuery.of(context).size.height * 0.7,
          right: 20,
        ),
        duration: const Duration(seconds: 10),
        backgroundColor: a == 1 ? Colors.green : Colors.red,
      ),
    );
  }
}
