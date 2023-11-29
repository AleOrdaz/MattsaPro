import 'package:appmattsa/features/lifting/presentation/providers/statuslifting/dropdown_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../liftings.dart';

final evidenceProvider = StateNotifierProvider.autoDispose
    .family<EvidenceNotifier, EvidenceState, String>((ref, liftingId) {
  final liftingRepository = ref.watch(productsRepositoryProvider);
  return EvidenceNotifier(
      liftingRepository: liftingRepository, liftingId: liftingId,ref:ref);
});

class EvidenceNotifier extends StateNotifier<EvidenceState> {
  final LiftingRepository liftingRepository;
  final ref;

  EvidenceNotifier({required this.liftingRepository, required String liftingId,required this.ref})
      : super(EvidenceState(id: liftingId)) {
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

      final lifting =
          await liftingRepository.getLift(int.parse(state.id), "ndskjda", 34);


        state = state.copyWith(
            isLoading: false, lifting: lifting);


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

  Future<void> changestatus() async {
    try {
      //TODO::AQUI VALIDAR PRIMERO QUE SEA NUEVO O SEA UNO YA EXISTE

      //AQUI EMPEZARE CON EL YA EXISTENTE

      final lifting =
          await liftingRepository.updatestate(int.parse(state.id), "ndskjda", 34);


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

class EvidenceState {
  final String id;
  final Lifting? lifting;
  final bool isLoading;
  final bool isSaving;

  EvidenceState({
    required this.id,
    this.lifting,
    this.isLoading = true,
    this.isSaving = false,
  });
  EvidenceState copyWith({
    String? id,
    Lifting? lifting,
    bool? isLoading,
    bool? isSaving,
  }) =>
      EvidenceState(
        id: id ?? this.id,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
        lifting: lifting ?? this.lifting,
      );
}
