import 'dart:async';

import 'package:appmattsa/config/config.dart';
import 'package:appmattsa/features/lifting/presentation/screens/processlifting/provider_pdf_final.dart';
import 'package:appmattsa/features/lifting/presentation/screens/serviceslifting/signaturePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../shared/shared.dart';
import '../../../liftings.dart';

class PdfFinalview extends StatelessWidget {

  static const name = "pdfview";
  const PdfFinalview({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: AppTheme.whiteMattsaLight,
      appBar: CustomAppBar(title: "Reporte Final"),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      body: _ReportView(),
    );
  }
}

class _ReportView extends ConsumerStatefulWidget {

  const _ReportView({super.key});

  @override
  ReportViewState createState() => ReportViewState();
}

class ReportViewState extends ConsumerState<_ReportView> {
  int count = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    crearPath();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t){
      print(singleton.timeLoader);
      if(count < singleton.timeLoader) {
        count = count + 5;
      } else {
        t.cancel();
      }
      if(mounted) {
        setState(() {});
      }
    });
    print('2------------------------');
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future crearPath() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pdfNotifier = ref.read(pdfFinatview.notifier);
      final path = ref.watch(selecteddocument);
      pdfNotifier.downloadAndOpenPDF(path!);
      singleton.pdf = path;
      print(path);
      print('------------------------1');
    });
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        setState(() {
          print('boton de atras');
          //timer.cancel();
        });
        return Future.value(true);
      },
      child: Center(
        child: Consumer(
            builder: (context, watch, _) {
              final state = ref.watch(pdfFinatview);
              print(state.path);
              print(count);
              if (count == singleton.timeLoader) {
                if (state.error != null) {
                  return Text('Error: ${state.error}');
                }
                if (state.path != null) { // return SfPdfViewer.asset(state.path!);
                  return PDFView(filePath: state.path!, autoSpacing: false);
                }
              }
              return CircularProgressIndicator();
            }
        ),
      ),
    );
  }
}
