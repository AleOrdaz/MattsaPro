
import 'package:appmattsa/features/lifting/presentation/providers/evidenceliftingafter/general_evidence_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../../../config/theme/app_theme.dart';
import '../../../providers/evidenceliftingafter/forms/evidence_form_provider.dart';



class MovieSliderFult extends ConsumerStatefulWidget {
  //  final StateNotifierProvider<SelectedImagesNotifier, List<File>> selectedImagesProvider;
  final idClase;
  final EvidenceFormState evidence;
  final EvidenceFormNotifier evidencenotifier;
  const MovieSliderFult({
    super.key,
    required this.idClase,
    required this.evidence,
    required this.evidencenotifier,
  });

  @override
  MovieSliderFulState createState() => MovieSliderFulState();
}

class MovieSliderFulState extends ConsumerState<MovieSliderFult> {
  late final StateNotifierProvider<SelectedImagesNotifier, List<File>>
      _selectedImagesProvider;

  @override
  void initState() {
    super.initState();
    _selectedImagesProvider =
        createSelectedImagesProvider(widget.idClase.toString());
  }

  @override
  Widget build(BuildContext context) {
    //  final selectedImagesProvider = StateNotifierProvider<SelectedImagesNotifier, List<File>>((ref) {
    //   return SelectedImagesNotifier();
    // });
    // final selectedImagesddd = ref.watch(selectedImagesProvider);
    final idLift = widget.evidence.idLifting;
    final selectedImages = ref.watch(_selectedImagesProvider);
    final dropdownDataList = widget.evidencenotifier.filtrar(widget.idClase);
    return Container(
      width: double.infinity,
      height: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      'Adjuntar aquí las imágenes correspondientes.',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                CustomButton(
                  idLift: idLift,
                  evidence: widget.evidence,
                  evidencenotifier: widget.evidencenotifier,
                  selectedImagesProvider: _selectedImagesProvider,
                  idClass: widget.idClase,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dropdownDataList.length,
                  itemBuilder: (_, int index) => Consumer(
                    builder: (context, ref, _) {
                      final dropdownData = dropdownDataList[index];
                      return _MoviePoster(
                        pathImage: dropdownData.pathDocument,
                        comentario: dropdownData.comment,
                        idEvidence: dropdownData.id,
                      );
                    },
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends ConsumerWidget {
  final File? imageFile;
  final String pathImage;
  final String? comentario;
  final int idEvidence;
  const _MoviePoster(
      {Key? key,
      this.imageFile,
      required this.pathImage,
      this.comentario,
      required this.idEvidence})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tetxcon = TextEditingController();
    tetxcon.text = comentario ?? 'sin comentarios';
    // ref.read(textEditingControllerProvider).text =
    //     comentario ?? "sin comentarios";
    // final fer = ref.watch(textEditingControllerProvider);
    // final nametypev;
    return Container(
      width: 130,
      height: 320,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Evidencia'),
                      content: SingleChildScrollView(
                        child: Column(children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            child: Opacity(
                              opacity: 1,
                              child: Container(
                                child: PhotoView(
                                  imageProvider: NetworkImage(pathImage),
                                  minScale:
                                      PhotoViewComputedScale.contained * 0.8,
                                  maxScale:
                                      PhotoViewComputedScale.covered * 2.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text('Comentarios:'),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: tetxcon,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: AppTheme.whiteMattsaLight,
                              hintText: 'Escribe tu comentario aquí...',
                            ),
                            maxLines: 3,
                            onChanged: (value) {
                              ref
                                  .read(comentarioProvider.notifier)
                                  .update((state) => value);
                            },
                          ),
                        ]),
                      ),
                      actions: [
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(AppTheme.blueMattsa),
                                ),
                                onPressed: () async {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.whiteMattsaLight,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5,),
                            Expanded(
                              flex: 6,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(AppTheme.blueMattsa),
                                ),
                                onPressed: () async {
                                  final comentario = ref.read(comentarioProvider);
                                  print(comentario);
                                  Navigator.of(context).pop();
                                  FocusScope.of(context).requestFocus(FocusNode());
                                },
                                child: const Text(
                                  ' Guardar ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.whiteMattsaLight,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  },
                );

                // Navigator.pushNamed(context, 'main_service',
                // arguments: 'movie-instance');
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    pathImage,
                  )
                  // child: Image.file(
                  //   imageFile,
                  //   width: 130,
                  //   height: 190,
                  //   fit: BoxFit.cover,
                  // ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends ConsumerWidget {
  final StateNotifierProvider<SelectedImagesNotifier, List<File>>
      selectedImagesProvider;

  final EvidenceFormState evidence;
  final EvidenceFormNotifier evidencenotifier;
  final idLift;

  final idClass;

  const CustomButton({
    required this.idClass,
    required this.selectedImagesProvider,
    required this.idLift,
    Key? key,
    required this.evidence,
    required this.evidencenotifier,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedImages = ref.watch(selectedImagesProvider.notifier);
    final picker = ImagePicker();
    Future<void> _getImage(ImageSource source) async {
      final pickedFile = await picker.pickImage(source: source,imageQuality: 40,);
      if (pickedFile != null) {
        // final idLift = ref.read(idlifting.notifier).state ?? -1;
        final image = File(pickedFile.path);
        selectedImages.addImage(image);
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Texto para leer'),
              content: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    width: 200,
                    height: 300,
                    child: Opacity(
                      opacity: 1,
                      child: Container(
                        child: PhotoView(
                          imageProvider: FileImage(image),
                          minScale: PhotoViewComputedScale.contained * 0.8,
                          maxScale: PhotoViewComputedScale.covered * 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Comentarios:'),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Escribe tu comentario aquí...',
                    ),
                    maxLines: 3,
                    onChanged: (value) {
                      ref
                          .read(comentarioProvider.notifier)
                          .update((state) => value);
                    },
                  ),
                ]),
              ),
              actions: [
                ///aqui se crea una nueva foto con comentarios
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(AppTheme.blueMattsa),
                        ),
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.whiteMattsaLight,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Expanded(
                      flex: 6,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(AppTheme.blueMattsa),
                        ),
                        onPressed: () async {
                          final comentario = ref.read(comentarioProvider);

                          final res = await evidencenotifier.enviarimagen(image,
                              comentario, idClass, int.parse(idLift));

                          print(comentario);
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          ' Actualizar ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.whiteMattsaLight,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        );

        // ignore: use_build_context_synchronously
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     TextEditingController _commentController = TextEditingController();
        //     return AlertDialog(
        //       title: const Text('Captured Image'),
        //       content: Column(
        //         children: [
        //           Image.file(image),
        //           const SizedBox(height: 16),
        //           TextField(
        //             controller: _commentController,
        //             decoration: const InputDecoration(
        //               hintText: 'Enter your comment...',
        //             ),
        //           ),
        //         ],
        //       ),
        //       actions: [
        //         ElevatedButton(
        //           onPressed: () {
        //             final comment = _commentController.text;
        //             // Enviar la imagen y el comentario a tu API
        //             ref
        //           .read(liftingDataProvider)
        //           .uploadImage(image, idLift, idClass)
        //           .then((value) => print(value));
        //             Navigator.of(context).pop();
        //           },
        //           child: const Text('Enviar'),
        //         ),
        //       ],
        //     );
        //   },
        // );
      }
    }

    return Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppTheme.blueMattsa,
      ),
      child: IconButton(
        icon: const Icon(Icons.camera_alt_outlined, color: AppTheme.whiteMattsaLight,),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: const Text(
                  'Selecciona o toma la evidencia', textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(AppTheme.blueMattsa),
                          ),
                          onPressed: () {
                            _getImage(ImageSource.gallery);
                            Navigator.of(context).pop();
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.image, color: AppTheme.whiteMattsaLight,),
                              Text(
                                ' Galeria',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.whiteMattsaLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8,),
                      Expanded(
                        flex: 5,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(AppTheme.blueMattsa),
                          ),
                          onPressed: () {
                            _getImage(ImageSource.camera);
                            Navigator.of(context).pop();
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.camera_alt, color: AppTheme.whiteMattsaLight,),
                              Text(
                                ' Cámara',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.whiteMattsaLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class MovieSlider extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final selectedImages = ref.watch(selectedImagesProvider.notifier).state;
    return Container(
      width: double.infinity,
      height: 270,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Adjuntar aquí las imágenes correspondientes.',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                // CustomButton(),
              ],
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}

// class _MoviePoster extends StatelessWidget {
//   final File imageFile;
//   const _MoviePoster({Key? key, required this.imageFile}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 130,
//       height: 320,
//       margin: EdgeInsets.symmetric(horizontal: 10),
//       child: Column(
//         children: [
//           Expanded(
//             child: GestureDetector(
//               onTap: () => Navigator.pushNamed(context, 'main_service',
//                   arguments: 'movie-instance'),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.file(
//                   imageFile,
//                   width: 130,
//                   height: 190,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomButton extends ConsumerWidget {
//   const CustomButton({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedImages = ref.watch(selectedImagesProvider.notifier).state;
//     final picker = ImagePicker();
//     Future<void> _getImage(ImageSource source) async {
//       final pickedFile = await picker.pickImage(source: source);
//       if (pickedFile != null) {
//         final image = File(pickedFile.path);
//         ref.read(selectedImagesProvider.notifier).state = [
//           ...selectedImages,
//           image
//         ];
//         // var selectedImagesss = ref.watch(selectedImagesProvider.notifier).state;
//         // print(selectedImagesss);
//       }
//     }

//     return IconButton(
//       icon: const Icon(Icons.camera_alt_outlined),
//       onPressed: () {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Select source'),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () {
//                     _getImage(ImageSource.gallery);
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('Gallery'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     _getImage(ImageSource.camera);
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('Camera'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }
