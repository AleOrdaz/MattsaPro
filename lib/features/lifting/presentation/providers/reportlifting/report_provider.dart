import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

final pdfProvider = StateNotifierProvider.autoDispose<PDFNotifier, PDFState>((ref) => PDFNotifier());
class PDFNotifier extends StateNotifier<PDFState> {
  PDFNotifier() : super(PDFState());
  Future<void> downloadAndOpenPDF(int idLifting) async {
    final url = 'https://mattsa.artendigital.mx/api/descargarodf/' + idLifting.toString();
    final response = await http.get(Uri.parse(url));
    final status = await Permission.storage.request();
    if (true) {//status.isGranted
      final directory = await getExternalStorageDirectory();
      final filePath = '${directory!.path}/file.pdf';
      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      state = PDFState(path: filePath);
    } else {
      state = PDFState(error: 'Permiso de escritura denegado');
    }
  }
}
class PDFState {
  final String? path;
  final String? error;
  PDFState({this.path, this.error});
}