import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../liftings.dart';

final EvidenceFormProvider = StateNotifierProvider.autoDispose
    .family<EvidenceFormNotifier, EvidenceFormState, Lifting>((ref, lifting) {
  // final createUpdateCallback =
  //     ref.watch(productsProvider.notifier).createOrUpdateProduct;
  //TODO: createdUpdateCallBack
  final productsRepository = ref.watch(productsRepositoryProvider);
  return EvidenceFormNotifier(
      lifting: lifting, liftingRepository: productsRepository, refg: ref
      // onSubmitCallback: createUpdateCallback,
      );
});

class EvidenceFormNotifier extends StateNotifier<EvidenceFormState> {
  final LiftingRepository liftingRepository;
  final Lifting lifting;
  dynamic refg;
  final Future<bool> Function(Map<String, dynamic> customerLike)?
      onSubmitCallback;

  EvidenceFormNotifier({
    required this.refg,
    required this.liftingRepository,
    this.onSubmitCallback,
    required this.lifting,
  }) : super(EvidenceFormState()) {
    adapativeConditions();
  }

  // Future<bool> onFormSubmit() async {
  //   if (onSubmitCallback == null) return false;

  //   final customerLike = {
  //     'id': (state.idLifting == '-1') ? null : state.idLifting,
  //     'id_custumer': state.idCliente,
  //     'id_oven': state.idHorno,
  //     'id_area': state.idZone,
  //     'id_domicilio': state.idDireccion,
  //     'service_type': state.idServicio,
  //     'name': state.name.value,
  //   };

  //   return await onSubmitCallback!(customerLike);
  // }

  void adapativeConditions() async {
    state = state.copyWith(isLoading: true);
    final alllist = await liftingRepository.getAllLift(lifting.id);
    final p = 0;
    // final lol = refg.read(dropdownStateProvider).selectedValues;
    state = state.copyWith(
        isLoading: false,
        evidencecompleta: alllist,
        idLifting: lifting.id.toString());
  }

  Color _getColor(String value, Color type) {
    switch (value) {
      case "1":
        type = const Color(0xFF222222);

        break;
      case "5":
        type = const Color(0xFFa80606);
        break;
      case "6":
        type = const Color(0xFFe3b100);
        break;
      case "7":
        type = const Color(0xFF25b1ff);
        break;
      default:
        type = const Color(0xFF56bf6d);
        break;
    }

    return type;
  }

  void onsubmit() async {
    // final Map<int, Mydata> respuestas =
    //     refg.read(dropdownStateProvider).selectedValues;
    // int fer = 0;

    // List<dynamic> likelist = [];

    // if (respuestas.isEmpty) return;
    // if (respuestas.length < state.clases!.length) return;

    // bool warn = false;
    // respuestas.forEach((k, v) {
    //   final likeobject = {
    //     'idClase': v.idClase,
    //     'idSemaforo': v.value,
    //     'idlifting': lifting.idLifting,
    //   };
    //   likelist.add(likeobject);
    // });

    // final statusLike = {
    //   'id': "no id",
    //   'list_status': likelist,
    // };

    // final p =
    //     await liftingRepository.createUpdateStatus(statusLike, "nkjfnksj");

    final prueba = 0;
    state = state.copyWith(
      isPosting: true,
    );
  }

  Future<bool> enviarimagen(
      File image, String comentario, int idClass, int idLifting) async {
    state = state.copyWith(isLoading: true);
    final res = await liftingRepository.uploadImage(
        image, idLifting, idClass, comentario);
    final newevidences = await liftingRepository.getAllLift(idLifting);

    state = state.copyWith(evidencecompleta: newevidences, isLoading: false);
    print(comentario);
    int p = 0;

    return true;
  }

  Future<bool> actualizarComentario(String comentario, int idEvidence) async {
    state = state.copyWith(isLoading: true);

    final res = await liftingRepository.updateComentarioevidence(
        idEvidence, comentario);
     state = state.copyWith(isLoading: false);
    //print(comentario);
    int p = 0;
    adapativeConditions();

    return true;
  }

  String? validate(int idClase) {
    // final Map<int, Mydata> classemaforo =
    //     refg.read(dropdownStateProvider).selectedValues;

    // if (classemaforo.isEmpty) return "Campo obligatorio";

    // bool warn = false;
    // classemaforo.forEach((k, v) {
    //   if (k == idClase) warn = true;
    // });
    // if (warn) return null;

    return "you have a lot errors";
  }

  List<Liftingevidence> filtrar(int idClase) {
    if (state.evidencecompleta == null) return [];
    if (state.evidencecompleta!.isEmpty) return [];

    List<Liftingevidence> aux = [];

    for (int i = 0; i < state.evidencecompleta!.length; i++) {
      if (state.evidencecompleta![i].myevidence!.isNotEmpty) {
        for (int j = 0;
            j < state.evidencecompleta![i].myevidence!.length;
            j++) {
          if (state.evidencecompleta![i].myevidence![j].idClass == idClase) {
            aux.add(state.evidencecompleta![i].myevidence![j]);
          }
        }
      }
    }

    return aux;
  }

  void changestatus() {
    state = state.copyWith(isInteraction: !state.isInteraction);
  }
  // void chargeLastlifting(Lifting lift) async {
  //   if (lift.idArea == -1 || lift.idArea == null) {
  //     state = state.copyWith(
  //       isloadingcustomer: true,
  //       isloadingdirection: true,
  //       isloadinghorno: true,
  //     );
  //     return;
  //   }

  //   state = state.copyWith(
  //     isloadingcustomer: false,
  //     isloadingdirection: false,
  //     isloadinghorno: false,
  //     name: Title.dirty(lift.nameLifting)
  //   );
  //   int idz = lift.idArea;
  //   final clientes = await liftingRepository.getCustomerZone(idz, "token");

  //   int auxcliente = lift.idCustomer ?? -1;

  //   final ovens = await liftingRepository.getAllOvens(auxcliente, "token");
  //   final direction = await liftingRepository.getDirection(auxcliente, "token");

  //   state = state.copyWith(
  //     isloadingcustomer: true,
  //     isloadingdirection: true,
  //     isloadinghorno: true,
  //     clientes: clientes,
  //     hornos: ovens,
  //     direcciones: direction,
  //   );
  // }
}

class EvidenceFormState {
  final isFormValid;
  final isPosting;
  final isLoading;
  final isInteraction;
  final String? idLifting;
  final List<NewExt>? evidencecompleta;

  EvidenceFormState({
    this.isInteraction = false,
    this.isPosting = false,
    this.isLoading = true,
    this.idLifting,
    this.evidencecompleta = const [],
    this.isFormValid = false,
  });

  EvidenceFormState copyWith({
    bool? isInteraction,
    bool? isPosting,
    bool? isLoading,
    bool? isFormValid,
    String? idLifting,
    List<NewExt>? evidencecompleta,
  }) =>
      EvidenceFormState(
        isInteraction: isInteraction ?? this.isInteraction,
        isFormValid: isFormValid ?? this.isFormValid,
        idLifting: idLifting ?? this.idLifting,
        evidencecompleta: evidencecompleta ?? this.evidencecompleta,
        isLoading: isLoading ?? this.isLoading,
        isPosting: isPosting ?? this.isPosting,
      );
}
