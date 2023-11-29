import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:appmattsa/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import '../../../../../shared/widgets/full_screen_loading.dart';
import '../../../../../singleton.dart';

Singleton singleton = Singleton();

class ReviewSignaturePage extends StatefulWidget {
  final Uint8List signature;
  final int idRemsion;
  final int idLifting;

  const ReviewSignaturePage(
      {Key? key, required this.signature, required this.idRemsion, required this.idLifting})
      : super(key: key);

  @override
  _RideState createState() => _RideState(signature: signature!,
    idRemsion: idRemsion, idLifting: idLifting, );
}

class _RideState extends State<ReviewSignaturePage> {
  final Uint8List signature;
  final int idRemsion;
  final int idLifting;

  _RideState(
      {Key? key, required this.signature, required this.idRemsion, required this.idLifting});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.whiteMattsaLight,
      appBar: AppBar(
        backgroundColor: AppTheme.blueMattsa,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        centerTitle: true,
        title: const Text(
          'Guardar y enviar firma',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Image.memory(signature),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.04),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppTheme.blueMattsa,
                        fixedSize: Size(size.width * .80, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        //'Aceptar',
                        'Cancelar',
                        style: TextStyle(
                            fontSize: 20, color: AppTheme.whiteMattsaLight),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    flex: 6,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppTheme.blueMattsa,
                        fixedSize: Size(size.width * .80, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          saveSignature(context);
                          singleton.hideShowLoader = true;
                        });
                      },
                      child: const Text(
                        //'Aceptar',
                        'Finalizar proceso',
                        style: TextStyle(
                            fontSize: 20, color: AppTheme.whiteMattsaLight),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          singleton.hideShowLoader ?  const FullScreenLoading() : Container()
        ],
      ),
    );
  }

  Future? saveSignature(BuildContext context) async {
    final status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    //making signature name unique
    final time = DateTime.now().toIso8601String().replaceAll('.', ':');
    final name = 'signature_$time';
    print(name);

    _uploadFile(name, context);
    print(signature);

    DateTime now = DateTime.now();
    Uint8List imageInUnit8List = signature;
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.png').create();
    file.writeAsBytesSync(imageInUnit8List);
    String filePath = '${tempDir.path}/firma_id.jpg';
    String fileName = filePath.split('/').last;
  }

  // Methode for file upload
  Future<void> _uploadFile(String name, BuildContext context) async {
    DateTime now = DateTime.now();

    Uint8List imageInUnit8List = signature;
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.png').create();
    file.writeAsBytesSync(imageInUnit8List);
    String filePath = '${tempDir.path}/firma_id.jpg';
    //File f1 = await File(listaFile[0].path).copy(filePath);

    print(filePath);
    String fileName = filePath.split('/').last;
    print("File base name: $fileName");

   /* var url = 'https://mattsa.artendigital.mx/api/upload/signature';
    var response = await http.post(Uri.parse(url),
        body: {
          'file': file.path,
        });
    print(url);https://mattsa.artendigital.mx/lifting/pdf/355
    print(response.body);*/

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://mattsa.artendigital.mx/api/upload/signature'),
    );
    // Agrega la imagen al request
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        file.path,
      ),
    );

    request.fields['idRemision'] = idRemsion.toString();

    // Envía el request y espera la respuesta
    var response = await request.send();

    print(response);
    // Lee la respuesta
    if (response.statusCode == 200/*response.body.contains('true')*/) {

      String res = "OK";
      context.push('/services/panel/${idLifting}');

      singleton.hideShowLoader = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Se guardo exitosamente la firma",
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 10),
            action: SnackBarAction(
              label: ' X ',
              onPressed: () {
                setState(() {
                  print('Action is clicked');
                });
              },
              textColor: Colors.white,
              disabledTextColor: Colors.grey,
            ),
          ),
        );
      });
      // return res;
    }
    else {
      singleton.hideShowLoader = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Error al subir imagen",
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 10),
            action: SnackBarAction(
              label: ' X ',
              onPressed: () {
                setState(() {
                  print('Action is clicked');
                });
              },
              textColor: Colors.white,
              disabledTextColor: Colors.grey,
            ),
          ),
        );
      });
      throw Exception('Error al subir imagen');
    }

    /*try {
      FormData formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(signature, filename: fileName),
      });
      print(formData.files);

      String url = '';
      if(constant.port == 12006) { url = constant.urlInterno; }
      else { url = constant.url; }

      await dio.post(url, data: formData).then((value) {
        print(value);
        if(value.toString() == '1') {//PROTOCOLO
        }
        else { //ERROR AL SUBIR ARCHIVO
        }
      });
    } catch (e) {
      print("Exception Caught: $e");
    }*/
  }
}
