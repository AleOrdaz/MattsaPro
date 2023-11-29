import 'package:appmattsa/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../../../infrastructure/infractructure.dart';

final productsRepositoryProvider = Provider.autoDispose<LiftingRepository>((ref) {
  
  final accessToken = ref.watch( authProvider ).user?.token ?? '';
  
  final productsRepository = LiftingRepository_impl(useCase: LiftingApi());

  return productsRepository;
});

