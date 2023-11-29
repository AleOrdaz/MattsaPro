import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/presentation/providers/auth_provider.dart';
import '../../../domain/domain.dart';
import 'liftings_repository_provider.dart';

final productsProvider =
    StateNotifierProvider.autoDispose<ProductsNotifier, ProductsState>((ref) {
  final authNotifier = ref.read(authProvider);
  final productsRepository = ref.watch(productsRepositoryProvider);
  return ProductsNotifier(
      productsRepository: productsRepository, auth: authNotifier);
});

class ProductsNotifier extends StateNotifier<ProductsState> {
  final LiftingRepository productsRepository;
  final auth;

  ProductsNotifier({required this.productsRepository, required this.auth})
      : super(ProductsState()) {
    loadNextPage();
  }

  Future<int> createOrUpdateProduct(Map<String, dynamic> productLike) async {
    try {
      final product = await productsRepository.createUpdateProduct(productLike);
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

    print(auth.user);

    state = state.copyWith(isLoading: true);

    final products = await productsRepository.getLiftingsnextPage(
        state.limit, state.offset, "falsotoken", auth.user.id);

    if (products.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    if (state  != null) {
      state = state.copyWith(
          isLastPage: false,
          isLoading: false,
          offset: state.offset + 10,
          products: [...state.products, ...products]);
    }
  }

  Future loadPage() async {
    if (state.isLoading || state.isLastPage) return;

    print(auth.user);

    state = state.copyWith(isLoading: true);

    final products = await productsRepository.getLiftingsnextPage(
        10, 0, "falsotoken", auth.user.id);

    state = state
        .copyWith(isLastPage: false, isLoading: false, offset: 0, products: []);
  }
}

class ProductsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Lifting> products;

  ProductsState(
      {this.isLastPage = false,
      this.limit = 10,
      this.offset = 0,
      this.isLoading = false,
      this.products = const []});

  ProductsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Lifting>? products,
  }) =>
      ProductsState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        products: products ?? this.products,
      );
}
