import 'dart:ui';

import 'package:appmattsa/features/lifting/domain/domain.dart';
import 'package:appmattsa/features/lifting/presentation/providers/statuslifting/dropdown_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider.dart';

final StatusFormProvider = StateNotifierProvider.autoDispose
    .family<StatusFormNotifier, StatusFormState, Lifting>((ref, lifting) {
  // final createUpdateCallback =
  //     ref.watch(productsProvider.notifier).createOrUpdateProduct;
  //TODO: createdUpdateCallBack
  final productsRepository = ref.watch(productsRepositoryProvider);
  return StatusFormNotifier(
      lifting: lifting,
      liftingRepository: productsRepository,
      respuestas: [],
      refg: ref
      // onSubmitCallback: createUpdateCallback,
      );
});

class StatusFormNotifier extends StateNotifier<StatusFormState> {
  final LiftingRepository liftingRepository;
  final Lifting lifting;
  dynamic refg;
  final Future<bool> Function(Map<String, dynamic> customerLike)?
      onSubmitCallback;

  StatusFormNotifier({
    required this.refg,
    required this.liftingRepository,
    this.onSubmitCallback,
    required this.lifting,
    required List<LiftingSemaforo> respuestas,
  }) : super(StatusFormState(respuestas: respuestas)) {
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
    final clases =
        await liftingRepository.getClasesOven(lifting.idOven, "bsabjhdka");

    final semaforo = await liftingRepository.getSemaforo("jndjs");
    final fer = 0;

    final List<LiftingSemaforo> respuestas =
        await liftingRepository.getSemaforoLiftLink(lifting.id);

    if (respuestas.isNotEmpty) {
      for (int i = 0; i < respuestas.length; i++) {
        final yourcolor =
            _getColor(respuestas[i].idSemaforo.toString(), Colors.black26);
        Mydata mydata = Mydata(
            index: respuestas[i].idClase,
            mycolor: yourcolor,
            idClase: respuestas[i].idClase,
            value: respuestas[i].idSemaforo.toString());
        refg.read(dropdownStateProvider).selectedValues[respuestas[i].idClase] =
            mydata;
      }
    }

    final lol = refg.read(dropdownStateProvider).selectedValues;
    state = state.copyWith(
      isLoading: false,
      clases: clases,
      semaforo: semaforo,
    );
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

  Future<bool> onsubmit() async {
    final Map<int, Mydata> respuestas =
        refg.read(dropdownStateProvider).selectedValues;
    int fer = 0;

    List<dynamic> likelist = [];

    if (respuestas.isEmpty) {
      state = state.copyWith(
        isFormValid: true,
      );
      return false;
    }
    
    if (respuestas.length < state.clases!.length) {
      state = state.copyWith(
        isFormValid: true,
      );
      return false;
    }

    bool warn = false;
    respuestas.forEach((k, v) {
      final likeobject = {
        'idClase': v.idClase,
        'idSemaforo': v.value,
        'idlifting': lifting.idLifting,
      };
      likelist.add(likeobject);
    });

    final statusLike = {
      'id': "no id",
      'list_status': likelist,
    };
    state = state.copyWith(
      isPosting: true,
    );

    final p =
        await liftingRepository.createUpdateStatus(statusLike, "nkjfnksj");

    final prueba = 0;
    state = state.copyWith(
      isPosting: false,
    );

    return true;
  }

  String? validate(int idClase) {
    final Map<int, Mydata> classemaforo =
        refg.read(dropdownStateProvider).selectedValues;

    if (classemaforo.isEmpty) return "Campo obligatorio";

    bool warn = false;
    classemaforo.forEach((k, v) {
      if (k == idClase) warn = true;
    });
    if (warn) return null;

    return "you have a lot errors";
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

class StatusFormState {
  final isFormValid;
  final isPosting;
  final isLoading;
  final isInteraction;
  final String? idLifting;
  final List<Clase>? clases;
  final List<Semaforo>? semaforo;
  final List<LiftingSemaforo>? respuestas;

  StatusFormState({
    this.isInteraction = false,
    this.isPosting = false,
    this.isLoading = true,
    this.idLifting,
    this.clases = const [],
    this.semaforo = const [],
    this.respuestas = const [],
    this.isFormValid = false,
  });

  StatusFormState copyWith({
    bool? isInteraction,
    bool? isPosting,
    bool? isLoading,
    bool? isFormValid,
    String? idLifting,
    List<Clase>? clases,
    List<Semaforo>? semaforo,
    List<LiftingSemaforo>? respuestas,
  }) =>
      StatusFormState(
        isInteraction: isInteraction ?? this.isInteraction,
        isFormValid: isFormValid ?? this.isFormValid,
        idLifting: idLifting ?? this.idLifting,
        clases: clases ?? this.clases,
        semaforo: semaforo ?? this.semaforo,
        respuestas: respuestas ?? this.respuestas,
        isLoading: isLoading ?? this.isLoading,
        isPosting: isPosting ?? this.isPosting,
      );
}
