import 'dart:convert';

import 'package:gampah_app/models/model_user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // ignore: non_constant_identifier_names
  String base_url = 'http://192.168.1.12:8000/api/';
  String register = 'register';
  String login = 'login';

  Future<UserModel> registerUser(
    String name,
    String phone,
    String email,
    String roles,
    String password,
  ) async {
    var url = "$base_url$register";
    var header = {
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      'name': name,
      'email': email,
      'phone': phone,
      'roles': roles,
      'password': password
    });

    var response = await http.post(Uri.parse(url), headers: header, body: body);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];
      return user;
    } else {
      throw Exception("Gagal Register");
    }
  }

  Future<UserModel> loginUser(
    String email,
    String password,
  ) async {
    var url = "$base_url$login";
    var header = {
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({'email': email, 'password': password});

    var response = await http.post(Uri.parse(url), headers: header, body: body);
    print(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];
      return user;
    } else {
      throw Exception("Gagal Login");
    }
  }
}
