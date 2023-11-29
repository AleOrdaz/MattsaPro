import 'package:appmattsa/features/auth/domain/domain.dart';
import 'package:appmattsa/features/auth/domain/response/login_response.dart';
import 'package:appmattsa/features/auth/infrastructure/infrastructure.dart';
import 'package:appmattsa/shared/infrastructure/services/key_value_storage.dart';
import 'package:appmattsa/shared/infrastructure/services/key_value_storage_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authrepository = AuthentificationRepository_impl();
  final keyValueStorage = KeyValueStorageImpl();

  return AuthNotifier(
      authRepository: authrepository, keyValueStorageService: keyValueStorage);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthenticationRepository authRepository;
  final KeyValueStorage keyValueStorageService;
  AuthNotifier(
      {required this.authRepository, required this.keyValueStorageService})
      : super(AuthState()){
        checkAuthStatus();
      }

  Future<void> loginUser(String email, String password) async {
    try {
      final user = await authRepository.login(email, password);

      if (user.response == LoginResponse.ok) {
        _setLoggedUser(user.user!);
      }
      if (user.response == LoginResponse.accessDenied) {
        logout(errormessage: "credenciales no son correctas");
      }
      if (user.response == LoginResponse.networkError) {
        logout(errormessage: "Revisa tu conexion de internet");
      }
      if (user.response == LoginResponse.unknownError) {
        logout(errormessage: "Error desconocido");
      }
    } catch (error) {
      int p = 0;
    }

    // state = state.copyWith(authStatus: AuthStatus.authenticated);
  }

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>('token');

    if (token == null) return logout();

    try {
      final user = await authRepository.checkAuthStatus(token);
      if (user.response == LoginResponse.ok) {
        _setLoggedUser(user.user!);
      }else{
        logout();
      }
      
    } catch (e) {
      int p = 0;
    }
  }

  void _setLoggedUser(User user) async {
    String token = user.token as String;
    await keyValueStorageService.setKeyValue('token', token);
    state = state.copyWith(
      user: user,
      errorMessage: "",
      authStatus: AuthStatus.authenticated,
    );
  }

  Future<void> logout({String? errormessage}) async {
    await keyValueStorageService.removeKeyValue('token');
    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errormessage);
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = ''});

  AuthState copyWith(
          {AuthStatus? authStatus, User? user, String? errorMessage}) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          errorMessage: errorMessage ?? this.errorMessage);
}
