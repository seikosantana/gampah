import 'dart:convert';

import 'package:http/http.dart' as http;

class StatServices {
  final String baseUrl = "https://shamo.tanpabatasgroup.com/api/stats";

  Future<int?> getDriversCount() async {
    int? count;
    try {
      var response = await http.get(Uri.parse("$baseUrl/drivers"));
      Map<String, dynamic> body = jsonDecode(response.body);
      count = body["data"]["count"];
    } catch (err) {
      throw Exception("Something went wrong in getting driver statistics");
    }
    return count;
  }

  Future<int?> getContributors() async {
    int? count;
    try {
      var response = await http.get(Uri.parse("$baseUrl/contributors"));
      Map<String, dynamic> body = jsonDecode(response.body);
      count = body["data"]["count"];
    } catch (err) {
      throw Exception("Something went wrong in getting contributor statistics");
    }
    return count;
  }

  Future<int?> getFinishedTransactions() async {
    int? count;
    try {
      var response = await http.get(Uri.parse("$baseUrl/pickups"));
      Map<String, dynamic> body = jsonDecode(response.body);
      count = body["data"]["count"];
    } catch (err) {
      throw Exception("Something went wrong in getting pickup statistics");
    }
    return count;
  }

  Future<double?> getRewardUser(String role, int id) async {
    double? reward;
    try {
      var response = role == 'DRIVER'
          ? await http.get(Uri.parse("$baseUrl/reward/$id/driver"))
          : await http.get(Uri.parse("$baseUrl/reward/$id/reporter"));
      Map<String, dynamic> body = jsonDecode(response.body);
      reward = body["data"]["reward"];
    } catch (err) {
      throw Exception("Something wrong in getting the reward");
    }
    return reward;
  }
}
