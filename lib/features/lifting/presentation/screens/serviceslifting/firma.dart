import 'dart:typed_data';
import 'package:appmattsa/config/config.dart';
import 'package:appmattsa/features/lifting/presentation/screens/serviceslifting/signaturePage.dart';
import 'package:appmattsa/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signature/signature.dart';

class Firma extends StatefulWidget {
  int idRemision;
  int idLifting;
  Firma({Key? key, this.idRemision = 85, required this.idLifting}) : super(key: key);

  @override
  State<Firma> createState() => _HomePageState();
}

class _HomePageState extends State<Firma> {
  SignatureController? controller;
  final DateTime now = DateTime.now();

  bool bandSinDiferencia = false;

  @override
  void initState() {
    // we initialize the signature controller
    controller = SignatureController(penStrokeWidth: 5, penColor: Colors.black);

    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Variable para obtener el tamaño de la pantalla
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.1,
                  padding: const EdgeInsets.only(left: 20, top: 35, right: 30),
                  decoration: const BoxDecoration(
                    color: AppTheme.blueMattsa,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: AppTheme.whiteMattsaLight,
                            ),
                            Text(
                              'Regresar',
                              style: TextStyle(
                                  color: AppTheme.whiteMattsaLight, fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(),
                Expanded(
                    flex: 10,
                    child: Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2),
                        color: Colors.black
                      ),
                      child: Signature(
                        controller: controller!,
                        height: size.height * 0.65,
                        backgroundColor: AppTheme.whiteMattsaLight,
                      ),
                    )),
                buttonWidgets(context, widget.idRemision,widget.idLifting)!,
                //buildSwapOrientation(context)!,
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                bottom: 70,
              ),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Firma',
                    style: TextStyle(
                        color: AppTheme.whiteMattsaLight,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
            ),
          ],
        ));
  }

  Widget? buildSwapOrientation(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final newOrientation =
        isPortrait ? Orientation.landscape : Orientation.portrait;

        controller!.clear();

        setOrientation(newOrientation);
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPortrait
                  ? Icons.screen_lock_portrait
                  : Icons.screen_lock_landscape,
              size: 40,
            ),
            const SizedBox(
              width: 12,
            ),
            const Text(
              'Cambiar la orientación',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  void setOrientation(Orientation orientation) {
    if (orientation == Orientation.landscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  Widget? buttonWidgets(BuildContext context, int idRemision,int idLifting) => Container(
    padding: const EdgeInsets.all(8),
    color: AppTheme.blueMattsa,
    child: Row(
      children: [
        Expanded(
          flex: 5,
          child: InkWell(
            onTap: () async {
              if (controller!.isNotEmpty) {
                final signature = await exportSignature();
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => ReviewSignaturePage(
                    signature: signature!,
                    idRemsion: idRemision,
                    idLifting: idLifting,
                  )),
                ));
                controller!.clear();
              } else {
                showSnackBar(context, '¡Sin firma!',
                    'Para continuar debe de firmar.', 2);
              }
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check,
                  size: 40,
                  color: AppTheme.whiteMattsaLight,
                ),
                Text(
                  'Aceptar',
                  style: TextStyle(
                    color: AppTheme.whiteMattsaLight,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: InkWell(
            onTap: () {
              controller!.clear();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.close,
                  size: 40,
                  color: AppTheme.redMattsa,
                ),
                Text(
                  'Limpiar',
                  style: TextStyle(
                    color: AppTheme.whiteMattsaLight,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      exportBackgroundColor: Colors.white,
      penColor: Colors.black,
      points: controller!.points,
    );

    final signature = exportController.toPngBytes();

    print("soy una firma ");
    //enviar firma
    exportController.dispose(); //clean up the memory

    return signature;
  }

  void showSnackBar(
      BuildContext context, String titulo, String contenido, int a) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 65,
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
          bottom: MediaQuery.of(context).size.height * 0.8,
          right: 20,
        ),
        duration: const Duration(seconds: 5),
        backgroundColor: a == 1 ? Colors.green : Colors.red,
      ),
    );
  }
}
