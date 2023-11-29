import 'package:appmattsa/features/lifting/presentation/providers/statuslifting/dropdown_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../liftings.dart';

final statusProvider = StateNotifierProvider.autoDispose
    .family<StatusNotifier, StatusState, String>((ref, liftingId) {
  final liftingRepository = ref.watch(productsRepositoryProvider);
  return StatusNotifier(
      liftingRepository: liftingRepository, liftingId: liftingId,ref:ref);
});

class StatusNotifier extends StateNotifier<StatusState> {
  final LiftingRepository liftingRepository;
  final ref;

  StatusNotifier({required this.liftingRepository, required String liftingId,required this.ref})
      : super(StatusState(id: liftingId)) {
    loadStatusLifting();
  }

  void onsubmit() {
    final respuestas = ref.read(dropdownStateProvider).selectedValues;
    int fer = 0;
  }

  Lifting newemptyLifting() {
    return Lifting(
        nameLifting: '',
        idLifting: -1,
        idCustomer: -1,
        idOven: -1,
        idStatus: -1,
        idArea: -1,
        idService: -1,
        idDomicilio: -1);
  }

  Future<void> loadStatusLifting() async {
    try {
      //TODO::AQUI VALIDAR PRIMERO QUE SEA NUEVO O SEA UNO YA EXISTE

      //AQUI EMPEZARE CON EL YA EXISTENTE

      final respuestas =
          await liftingRepository.getSemaforoLiftLink(int.parse(state.id));

      final lifting =
          await liftingRepository.getLift(int.parse(state.id), "ndskjda", 34);

      if (respuestas.isNotEmpty) {
        state = state.copyWith(
            isLoading: false, respuesta: respuestas, lifting: lifting);
      } else {
        state = state.copyWith(
            isLoading: false, respuesta: respuestas, lifting: lifting);
      }

      // if (state.id == "new") {
      //   state = state.copyWith(
      //     isLoading: false,
      //     lifting: newemptyLifting(),
      //   );
      //   return;
      // }

      // final lifting =
      //     await liftingRepository.getLift(int.parse(state.id), "ndskjda", 34);

      // state = state.copyWith(isLoading: false, lifting: lifting);
    } catch (e) {
      print(e);
    }
  }
}

class StatusState {
  final String id;
  final List<LiftingSemaforo>? respuesta;
  final Lifting? lifting;
  final bool isLoading;
  final bool isSaving;

  StatusState({
    this.respuesta,
    required this.id,
    this.lifting,
    this.isLoading = true,
    this.isSaving = false,
  });
  StatusState copyWith({
    List<LiftingSemaforo>? respuesta,
    String? id,
    Lifting? lifting,
    bool? isLoading,
    bool? isSaving,
  }) =>
      StatusState(
        id: id ?? this.id,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
        respuesta: respuesta ?? this.respuesta,
        lifting: lifting ?? this.lifting,
      );
}
