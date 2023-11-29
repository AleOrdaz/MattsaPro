import 'package:appmattsa/features/lifting/domain/models/entregables.dart';
import 'package:appmattsa/features/lifting/domain/models/ot.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../shared/shared.dart';
import '../../../../liftings.dart';

final selecteddocument = StateProvider<String?>((ref) => null);

final panelFormProvider = StateNotifierProvider.autoDispose
    .family<PanelFormNotifier, PanelFormState, Lifting>((ref, lifting) {
  final createUpdateCallback =
      ref.watch(productsProvider.notifier).createOrUpdateProduct;
  //TODO: createdUpdateCallBack
  final productsRepository = ref.watch(productsRepositoryProvider);
  return PanelFormNotifier(
    lifting: lifting,
    liftingRepository: productsRepository,
    onSubmitCallback: createUpdateCallback,
  );
});

class PanelFormNotifier extends StateNotifier<PanelFormState> {
  final LiftingRepository liftingRepository;
  final Future<int> Function(Map<String, dynamic> customerLike)?
      onSubmitCallback;

  PanelFormNotifier({
    required this.liftingRepository,
    this.onSubmitCallback,
    required Lifting lifting,
  }) : super(PanelFormState(
          idLifting: lifting.id.toString(),
        )) {
    chargeLastlifting(lifting);
  }

  Future<int> onFormSubmit() async {
    return await liftingRepository.setCommentAct(
        int.parse(state.idLifting!), state.comentario.value);

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

    final ot= await liftingRepository.getDocumentot(lift.id);
    final remision= await liftingRepository.getDocumentremision(lift.id);
    final entregable= await liftingRepository.getEntregables(lift.id);
    final p = 0;
    state = state.copyWith(
        comentario: Title.dirty(lift.description ?? ''),
        isloading: false,
        documentOt: ot,
        documentremision: remision,
        entregables: entregable,
        informacion: semaforoaux);
    final po = 0;
  }

  void onTitleChanged(String value) {
    state = state.copyWith(
      comentario: Title.dirty(value),
      
    );
  }
}

class PanelFormState {
  final Title comentario;
  final bool isloading;
  final List<SemaforoAux> informacion;
  final List<OtDocument>? documentOt;
  final List<OtDocument>? documentremision;
  final List<Entregable>? entregables;
  final bool isFormValid;
  final String? idLifting;

  PanelFormState({
    this.comentario = const Title.dirty(''),
    this.isloading = true,
    this.isFormValid = true,
    this.idLifting,
    this.informacion = const [],
    this.documentOt=const[],
    this.documentremision=const[],
    this.entregables=const[],
  });

  PanelFormState copyWith(
          {Title? comentario,
          bool? isloading,
          bool? isFormValid,
          String? idLifting,
          List<SemaforoAux>? informacion,
          List<OtDocument>? documentOt,
          List<OtDocument>? documentremision,
            List<Entregable>? entregables}) =>
      PanelFormState(
        comentario: comentario ?? this.comentario,
        isloading: isloading ?? this.isloading,
        isFormValid: isFormValid ?? this.isFormValid,
        idLifting: idLifting ?? this.idLifting,
        informacion: informacion ?? this.informacion,
        documentremision: documentremision ?? this.documentremision,
        documentOt: documentOt ?? this.documentOt,
        entregables: entregables ?? this.entregables,
      );
}
