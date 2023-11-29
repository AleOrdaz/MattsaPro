import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerProvider = Provider<ImagePicker>((ref) {
  return ImagePicker();
});

// StateNotifierProvider<SelectedImagesNotifier, List<File>> createSelectedImagesProvider() {
//   return StateNotifierProvider<SelectedImagesNotifier, List<File>>((ref) {
//     return SelectedImagesNotifier();
//   });
// }

class SelectedImagesNotifierForMovieSliderFul
    extends StateNotifier<List<File>> {
  SelectedImagesNotifierForMovieSliderFul() : super([]);

  void addImage(File image) {
    state = [...state, image];
  }

  void removeImage(File image) {
    state = List<File>.from(state)..remove(image);
  }
}

StateNotifierProvider<SelectedImagesNotifier, List<File>>
    createSelectedImagesProvider(String idClase) {
  return StateNotifierProvider<SelectedImagesNotifier, List<File>>((ref) {
    return SelectedImagesNotifier(idClase);
  });
}

class SelectedImagesNotifier extends StateNotifier<List<File>> {
  final String idClase;

  SelectedImagesNotifier(this.idClase) : super([]);

  void addImage(File image) {
    state = [...state, image];
  }

  void removeImage(File image) {
    state = List<File>.from(state)..remove(image);
  }
}

final comentarioProvider = StateProvider<String>((ref) => '');


final iseditevidence = StateProvider<bool?>((ref) => null);