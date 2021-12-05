import 'package:flutter/cupertino.dart';
import 'package:gampah_app/models/model_user.dart';
import 'package:gampah_app/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<bool> login(
    String email,
    String password,
  ) async {
    try {
      UserModel user = await AuthService().loginUser(email, password);
      _user = user;
      //check value in shared Preference
      // SharedPreferences localStorage = await SharedPreferences.getInstance();
      // localStorage.setString("token", user.token);
      // print(localStorage.getString("token"));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
