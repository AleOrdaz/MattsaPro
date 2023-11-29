import '../models/manageauth.dart';
import '../models/user.dart';

abstract class AuthenticationRepository {
  Future<String?> get accessToken;
  Future<ManageAuth> login(String email, String password);

  Future<User> loginUser(String password, String email);

  Future<ManageAuth> checkAuthStatus(String token);
}
