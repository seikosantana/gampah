import 'package:flutter/cupertino.dart';
import 'package:gampah_app/models/model_user.dart';
import 'package:gampah_app/services/auth_services.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  UserModel? get getUser => _user;
  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register(
    String name,
    String phone,
    String email,
    String roles,
    String password,
  ) async {
    try {
      UserModel user =
          await AuthService().registerUser(name, phone, email, roles, password);
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
