import 'package:appmattsa/features/lifting/domain/models/entregables.dart';
import 'package:appmattsa/features/lifting/domain/models/ot.dart';
import 'package:appmattsa/features/lifting/presentation/providers/panelgeneralservices/provider.general.dart';
import 'package:appmattsa/features/lifting/presentation/screens/serviceslifting/firma.dart';
import 'package:appmattsa/features/lifting/presentation/screens/serviceslifting/signaturePage.dart';
import 'package:appmattsa/features/lifting/presentation/screens/serviceslifting/webViewDeliveries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../liftings.dart';

class CardoT extends ConsumerWidget {
  final List<OtDocument> ot;
  final bool isremision;
  final int val;
  const CardoT({
    super.key,
    required this.ot,
    this.isremision=false,
    required this.val
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
      constraints: const BoxConstraints(maxHeight: 100),
      child: ListView.builder(
        itemCount: ot.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () {
                print(ot[index].path);
                singleton.timeLoader = 10;
                ref.read(selecteddocument.notifier).update(
                        (state) => ot[index].path);
                context.push("/pdfview");
                // Navigator.pushNamed(context, 'pdfview');
                // Acción al hacer clic en el botón

              },
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Text(
                      "${index + 1}.- ${ot[index].cseriedocumento}-${ot[index].cfolio}",
                      style: const TextStyle(
                        decoration: TextDecoration.underline, // Opcional: añadir subrayado u otros estilos de texto
                        color: Colors.blue, // Opcional: establecer color del texto
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: val == 1 ? IconButton.filled(
                      padding: const EdgeInsets.all(2),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Firma(idRemision: ot[index].idOt,idLifting: ot[index].idLifting,)));
                        },
                      icon: const Icon(Icons.drive_file_rename_outline,),
                    ) : Container(),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}


class CardEntregable extends ConsumerWidget {
  final List<Entregable> entregables;
  final bool isremision;
  final int val;
  const CardEntregable({
    super.key,
    required this.entregables,
    this.isremision=false,
    required this.val
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 100),
      child: ListView.builder(
          itemCount: entregables.length,
          itemBuilder: (context, index) {
            print(entregables[index]);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: InkWell(
                onTap: () {
                  singleton.timeLoader = 20;
                  print(entregables[index].path);
                  ref.read(selecteddocument.notifier).update(
                          (state) => entregables[index].path);
                  context.push("/pdfview");
                  /*Navigator.push(context, MaterialPageRoute(
                      builder: (context) => webview(url : ot[index].real_path)));*/
                  // Navigator.pushNamed(context, 'pdfview');
                  // Acción al hacer clic en el botón
                },
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Text(
                        "${index + 1}.- Entregable",
                        style: const TextStyle(
                          decoration: TextDecoration.underline, // Opcional: añadir subrayado u otros estilos de texto
                          color: Colors.blue, // Opcional: establecer color del texto
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: val == 1 ? IconButton.filled(
                        padding: const EdgeInsets.all(2),
                        onPressed: (){
                          print(entregables[index].path);
                          singleton.timeLoader = 10;
                          ref.read(selecteddocument.notifier).update(
                                  (state) => entregables[index].path);
                          context.push("/pdfview");
                        },
                        icon: const Icon(Icons.remove_red_eye,),
                      ) : Container(),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
