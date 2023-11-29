import 'package:appmattsa/features/lifting/liftings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final customerProvider = StateNotifierProvider.autoDispose
    .family<CustomerNotifier, CustomerState, String>((ref, liftingId) {
  final liftingRepository = ref.watch(productsRepositoryProvider);
  return CustomerNotifier(
      liftingRepository: liftingRepository, liftingId: liftingId);
});

class CustomerNotifier extends StateNotifier<CustomerState> {
  final LiftingRepository liftingRepository;

  CustomerNotifier({required this.liftingRepository, required String liftingId})
      : super(CustomerState(id: liftingId)) {
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
        idPart: -1,
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

class CustomerState {
  final String id;
  final Lifting? lifting;
  final bool isLoading;
  final bool isSaving;

  CustomerState({
    required this.id,
    this.lifting,
    this.isLoading = true,
    this.isSaving = false,
  });
  CustomerState copyWith({
    String? id,
    Lifting? lifting,
    bool? isLoading,
    bool? isSaving,
  }) =>
      CustomerState(
        id: id ?? this.id,
        lifting: lifting ?? this.lifting,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
