import 'package:appmattsa/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../liftings.dart';

final servicesProvider =
    StateNotifierProvider.autoDispose<ServiceNotifier, ServiceState>((ref) {
      final authNotifier = ref.read(authProvider);
  final servicesRepository = ref.watch(productsRepositoryProvider);
  return ServiceNotifier(servicesRepository: servicesRepository,auth:authNotifier );
});

class ServiceNotifier extends StateNotifier<ServiceState> {
  final LiftingRepository servicesRepository;
  final auth;

  ServiceNotifier({required this.servicesRepository, required this.auth})
      : super(ServiceState()) {
    loadNextPage();
  }



///this is not necessary
  Future<int> createOrUpdateProduct(Map<String, dynamic> productLike) async {
    try {
      final product = await servicesRepository.createUpdateProduct(productLike);
      final isProductInList =
          state.products.any((element) => element.id == product.id);

      if (!isProductInList) {
        state = state.copyWith(products: [...state.products, product]);
        return product.idLifting;
      }

      state = state.copyWith(
          products: state.products
              .map(
                (element) => (element.id == product.id) ? product : element,
              )
              .toList());
      return product.idLifting;
    } catch (e) {
      return -1;
    }
  }

  
  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    

    state = state.copyWith(isLoading: true);

    final products = await servicesRepository.getServicesnextPage(
        state.limit, state.offset, "falsotoken",auth.user.id);

    if (products.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        products: [...state.products, ...products]);
  }
}

class ServiceState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Lifting> products;

  ServiceState(
      {this.isLastPage = false,
      this.limit = 10,
      this.offset = 0,
      this.isLoading = false,
      this.products = const []});

  ServiceState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Lifting>? products,
  }) =>
      ServiceState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        products: products ?? this.products,
      );
}
