import 'package:appmattsa/features/lifting/liftings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activityProvider = StateNotifierProvider.autoDispose
    .family<ActivityNotifier, ActivityState, String>((ref, liftingId) {
  final liftingRepository = ref.watch(productsRepositoryProvider);
  return ActivityNotifier(
      liftingRepository: liftingRepository, liftingId: liftingId);
});

class ActivityNotifier extends StateNotifier<ActivityState> {
  final LiftingRepository liftingRepository;

  ActivityNotifier({required this.liftingRepository, required String liftingId})
      : super(ActivityState(id: liftingId)) {
    loadLifting();
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

  Future<void> loadLifting() async {
    try {

      if(state.id=="new"){
        state = state.copyWith(
          isLoading: false,
          lifting: newemptyLifting(),
        );  
        return;
      }


      final lifting =
          await liftingRepository.getLift(int.parse(state.id), "ndskjda", 34);

      state = state.copyWith(isLoading: false, lifting: lifting);
    } catch (e) {
      print(e);
    }
  }
}

class ActivityState {
  final String id;
  final Lifting? lifting;
  final bool isLoading;
  final bool isSaving;

  ActivityState({
    required this.id,
    this.lifting,
    this.isLoading = true,
    this.isSaving = false,
  });
  ActivityState copyWith({
    String? id,
    Lifting? lifting,
    bool? isLoading,
    bool? isSaving,
  }) =>
      ActivityState(
        id: id ?? this.id,
        lifting: lifting ?? this.lifting,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
