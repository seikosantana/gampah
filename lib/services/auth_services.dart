// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:gampah_app/models/model_user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // ignore: non_constant_identifier_names
  String base_url = 'http://127.0.0.1:8000/api/auth/';
  String register = 'register';
  String login = 'login';
  String logout = 'logout';

  Future<UserModel> loginUser(
    String email,
    String password,
  ) async {
    var url = "$base_url/$login";
    var header = {
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({'email': email, 'password': password});

    var response = await http.post(Uri.parse(url), headers: header, body: body);

    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", user.token);
      return user;
    } else {
      throw Exception("Gagal Login");
    }
  }

  Future<UserModel> registerUser(
    String name,
    String phone,
    String email,
    String password,
  ) async {
    var url = "$base_url/$login";
    var header = {
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    });

    var response = await http.post(Uri.parse(url), headers: header, body: body);

    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", user.token);
      return user;
    } else {
      throw Exception("Gagal Login");
    }
  }
}
