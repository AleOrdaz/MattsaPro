import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../shared/shared.dart';
import '../../../../liftings.dart';

final activityFormProvider = StateNotifierProvider.autoDispose
    .family<ActivityFormNotifier, ActivityFormState, Lifting>((ref, lifting) {
  final createUpdateCallback =
      ref.watch(productsProvider.notifier).createOrUpdateProduct;
  //TODO: createdUpdateCallBack
  final productsRepository = ref.watch(productsRepositoryProvider);
  return ActivityFormNotifier(
    lifting: lifting,
    liftingRepository: productsRepository,
    onSubmitCallback: createUpdateCallback,
  );
});

class ActivityFormNotifier extends StateNotifier<ActivityFormState> {
  final LiftingRepository liftingRepository;
  final Future<int> Function(Map<String, dynamic> customerLike)?
      onSubmitCallback;

  ActivityFormNotifier({
    required this.liftingRepository,
    this.onSubmitCallback,
    required Lifting lifting,
  }) : super(ActivityFormState(
          idLifting: lifting.id.toString(),
        )) {
    chargeLastlifting(lifting);
  }

  Future<int> onFormSubmit() async {
    return await liftingRepository.setCommentAct(int.parse(state.idLifting!), state.comentario.value);

    //   if (onSubmitCallback == null) return -1;

    //   final customerLike = {
    //     'id': (state.idLifting == '-1') ? null : state.idLifting,
    //     'id_custumer': state.idCliente,
    //     'id_oven': state.idHorno,
    //     'id_area': state.idZone,
    //     'id_domicilio': state.idDireccion,
    //     'service_type': state.idServicio,
    //     'name': state.name.value,
    //   };

    //  return await onSubmitCallback!(customerLike);
  }

  String? validate(String p) {
    return null;
  }

  void chargeLastlifting(Lifting lift) async {
    final semaforoaux = await liftingRepository.getAllLiftSemaforo(lift.id);
    final p = 0;
    state = state.copyWith(
        comentario: Title.dirty(lift.description ?? ''),
        isloading: false,
        informacion: semaforoaux);
    final po = 0;
  }

  void onTitleChanged(String value) {
    state = state.copyWith(
      comentario: Title.dirty(value),
    );
  }
}

class ActivityFormState {
  final Title comentario;
  final bool isloading;
  final List<SemaforoAux> informacion;

  final bool isFormValid;
  final String? idLifting;

  ActivityFormState({
    this.comentario = const Title.dirty(''),
    this.isloading = true,
    this.isFormValid = true,
    this.idLifting,
    this.informacion = const [],
  });

  ActivityFormState copyWith({
    Title? comentario,
    bool? isloading,
    bool? isFormValid,
    String? idLifting,
    List<SemaforoAux>? informacion,
  }) =>
      ActivityFormState(
        comentario: comentario ?? this.comentario,
        isloading: isloading ?? this.isloading,
        isFormValid: isFormValid ?? this.isFormValid,
        idLifting: idLifting ?? this.idLifting,
        informacion: informacion ?? this.informacion,
      );
}
