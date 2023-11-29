import 'package:appmattsa/features/auth/domain/models/user.dart';
import 'package:appmattsa/features/auth/domain/response/login_response.dart';

class ManageAuth {
  User? user;
  LoginResponse response;

  ManageAuth({this.user, required this.response});
}
