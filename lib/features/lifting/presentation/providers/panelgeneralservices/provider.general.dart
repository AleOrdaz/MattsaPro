import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

final pdfotview = StateNotifierProvider<PDFNotifierView, PDFStateVie>((ref) => PDFNotifierView());
class PDFNotifierView extends StateNotifier<PDFStateVie> {
  PDFNotifierView() : super(PDFStateVie());
  Future<void> downloadAndOpenPDF(String link) async {
    final url = link;
    final response = await http.get(Uri.parse(url));
    final status = await Permission.storage.request();
    if (true) {//status.isGranted
      final directory = await getExternalStorageDirectory();
      final filePath = '${directory!.path}/file.pdf';
      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      state = PDFStateVie(path: filePath);
    } else {
      state = PDFStateVie(error: 'Permiso de escritura denegado');
    }
  }
}
class PDFStateVie {
  late final String? path;
  final String? error;
  PDFStateVie({this.path, this.error});
}