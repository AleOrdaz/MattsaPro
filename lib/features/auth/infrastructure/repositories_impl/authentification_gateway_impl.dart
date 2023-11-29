import '../../domain/domain.dart';
import '../../domain/models/manageauth.dart';
import '../../domain/use_case/authentication.dart';
import '../infrastructure.dart';

class AuthentificationRepository_impl extends AuthenticationRepository {
  final AuthentificationUseCase useCase;

  AuthentificationRepository_impl({AuthentificationUseCase? useCase})
      : useCase = useCase ?? AuthentificationApi();

  @override
  // TODO: implement accessToken
  Future<String?> get accessToken => throw UnimplementedError();

  @override
  Future<ManageAuth> checkAuthStatus(String token) {
    return useCase.checkAuthStatus(token);
  }

  @override
  Future<ManageAuth> login(String email, String password) {
    return useCase.login(email, password);
  }

  @override
  Future<User> loginUser(String password, String email) {
    return useCase.loginUser(password, email);
  }
}
