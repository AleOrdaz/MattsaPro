import 'dart:convert';

import 'package:appmattsa/config/config.dart';
import 'package:appmattsa/features/lifting/presentation/screens/serviceslifting/signaturePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../../shared/shared.dart';
import '../../../liftings.dart';

class ReportScreen extends StatelessWidget {
  final String liftingId;
  static const name = "reporte_lifting";
  ReportScreen({super.key, required this.liftingId, required});

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Contactar administracion para convertirla en Orden de trabajo.')));
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: AppTheme.whiteMattsaLight,
      appBar: CustomAppBar(title: "Solicitar orden de trabajo"),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      body: _ReportView(liftingId: liftingId),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.blueMattsa,
          label: const Text(
            'Solicitar orden de trabajo',
            style: TextStyle(color: AppTheme.whiteMattsaLight, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            showSnackbar(context);
            context.push('/mainlifting');
          },
          icon: const Icon(Icons.save_as_outlined, color: AppTheme.whiteMattsaLight,)),
    );
  }
}

class _ReportView extends ConsumerStatefulWidget {
  final String liftingId;
  const _ReportView({super.key, required this.liftingId});

  @override
  ReportViewState createState() => ReportViewState();
}

class ReportViewState extends ConsumerState<_ReportView> {
  String id = "";
  bool band = false;
  final _items = singleton.userEmail
      .map((user) => MultiSelectItem<UsersEmails?>(user, '${user.name} (${user.email})'))
      .toList();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final idLift = widget.liftingId;
      id = idLift;
      final pdfNotifier = ref.read(pdfProvider.notifier);
      pdfNotifier.downloadAndOpenPDF(
          int.parse(idLift)); // Reemplaza con el ID correcto
    });
  }

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('No se ha seleccionado ningun correo')));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 8,
                          child: SingleChildScrollView(
                            child: MultiSelectBottomSheetField(
                                items: _items,
                                searchable: true,
                                confirmText: const Text(
                                  'Confirmar',
                                  style: TextStyle(color: AppTheme.blueMattsa, fontSize: 17),
                                ),
                                cancelText: const Text(
                                  'Cancelar',
                                  style: TextStyle(color: AppTheme.redMattsa, fontSize: 17),
                                ),
                                searchHint: 'Buscar',
                                title: const Text(
                                  "Correos",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppTheme.blueMattsa,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                selectedColor: AppTheme.blueMattsa,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.all(Radius.circular(40)),
                                  border: Border.all(
                                    color: AppTheme.blueMattsa,
                                    width: 2,
                                  ),
                                ),
                                backgroundColor: AppTheme.whiteMattsaLight,
                                buttonIcon: const Icon(
                                  Icons.email_outlined,
                                  color: AppTheme.blueMattsa,
                                ),
                                buttonText: const Text(
                                  "Selecciona los correos",
                                  style: TextStyle(
                                      color: AppTheme.blueMattsa,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                onConfirm: (results) {
                                  print("-------------results");
                                  singleton.emails = [];
                                  if(results.length > 0) {
                                    for (int i = 0; i < results.length; i ++) {
                                      singleton.emails.add((results[i]!.email));
                                    }
                                  } else {
                                    singleton.emails = [];
                                  }
                                  print(singleton.emails);
                                },
                              ),
                            ),
                          /*DropdownButtonFormField(
                      isExpanded: true,
                      value: user,
                      style: const TextStyle(color: Colors.black,fontSize: 16),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: AppTheme.whiteMattsaLight,
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: singleton.userEmailSinId.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue){
                        user = newValue!;
                        print(user);
                      },
                    ),*/
                        ),
                        const SizedBox(width: 5,),
                        Expanded(
                          flex: 4,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(AppTheme.redMattsa),
                              ),
                              onPressed: () {
                                setState(() {
                                  print(singleton.emails);
                                  if (singleton.emails.isNotEmpty) {
                                    band = true;
                                    sendEmail(id);
                                  } else {
                                    showSnackbar(context);
                                  }
                                });
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Enviar ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.whiteMattsaLight,
                                    ),
                                  ),
                                  Icon(Icons.send, color: AppTheme.whiteMattsaLight, size: 21,),
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              Expanded(
                  flex: 8,
                  child: Consumer(
                    builder: (context, watch, _) {
                      final state = ref.watch(pdfProvider);
                      if (state.error != null) {
                        return Text('Error: ${state.error}');
                      }
                      if (state.path != null) {
                        // return SfPdfViewer.asset(state.path!);
                        return PDFView(filePath: state.path!, autoSpacing: false);
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: band ? const FullScreenLoading() : Container(),
        )
      ],
    );
  }

  Future<String> sendEmail(String idLift) async {
    String arrayEmails = "";

    for(int i = 0; i < singleton.emails.length; i++){
      if(i == 0) {
        arrayEmails = '${singleton.emails[0]}';
      } else {
        arrayEmails = '$arrayEmails|${singleton.emails[0]}';
      }
    }
    print(arrayEmails);

    var url = 'https://mattsa.artendigital.mx/api/get/send/email/lifting';
    var response = await http.post(Uri.parse(url),
        body: {
          'idLifting': idLift,
          'email': arrayEmails,
        });
    print(url);
    print(response.body);
    if(!response.body.contains("<!doctype html>")) {
      if (response.body.contains("true")) {
        setState(() {
          band = false;
        });
        print('=======TOKEN=========');
        showSnackBar(
            context, "", "Correo enviado con éxito\n", 1);
        return "resp['id']";
      }
      else {
        setState(() {
          band = false;
        });
        print("error en la consulta");
        var error = jsonDecode(response.body);
        print(error['error']['code']);
        showSnackBar(
            context, "Envio fallido", "No se pudo mandar el correo", 2);
        return "(error['error']['code'])";
      }
    } else {
      setState(() {
        band = false;
      });
      showSnackBar(
          context, "Envio fallido", "No se pudo mandar el correo", 2);
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
                      style: const TextStyle(fontSize: 18),
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
        duration: const Duration(seconds: 5),
        backgroundColor: a == 1 ? Colors.green : Colors.red,
      ),
    );
  }
}
