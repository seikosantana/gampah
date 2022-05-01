// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:gampah_app/models/model_transactions.dart';
import 'package:gampah_app/models/model_transactions_detail.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransactionsService {
  String base_url = 'https://shamo.tanpabatasgroup.com/api/';
  String transactions = 'transactions';
  String listTransactions = 'transactions/';
  String detail = '/details';
  String update = 'transactions/operations/';
  String observation = '/observation';
  String cleanup = '/cleanup';
  Future<Map<String, dynamic>> addTransaction(
    int reporterId,
    String addressDetail,
    String status,
    double latitude,
    double longitude,
    String image,
  ) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString("token").toString();
    var url = "$base_url$transactions";
    var header = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8',
      'Authorization': token
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(header);
    request.fields['reporter_id'] = reporterId.toString();
    request.fields['address_detail'] = addressDetail;
    request.fields['status'] = status;
    request.fields['latitude'] = latitude.toString();
    request.fields['longitude'] = longitude.toString();
    request.files.add(await http.MultipartFile.fromPath('report_img', image));

    var responseServer = await request.send();
    var responseCallback = await http.Response.fromStream(responseServer);
    final valueBody = jsonDecode(responseCallback.body);
    print(responseCallback);
    if (responseCallback.statusCode == 200) {
      print("success");
      print(valueBody);
      return valueBody;
    } else {
      print("failed");
      return valueBody;
    }
  }

  Future<Map<String, dynamic>> updateTransaction(id, path, String image) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString("token").toString();
    var url;
    if (path == 'observation_img') {
      url = '$base_url$update$id$observation';
    } else {
      url = '$base_url$update$id$cleanup';
    }
    var header = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8',
      'Authorization': token
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(header);
    request.files.add(await http.MultipartFile.fromPath('$path', image));
    var responseServer = await request.send();
    var responseCallback = await http.Response.fromStream(responseServer);
    final valueBody = jsonDecode(responseCallback.body);
    print(responseCallback);
    if (responseCallback.statusCode == 200) {
      print("success");
      print(valueBody);
      return valueBody;
    } else {
      print("failed");
      return valueBody;
    }
  }

  Future<Transactions> allTransactionsByToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString("token").toString();
    String url = "$base_url$listTransactions";
    var headers = {
      'Accept': 'application/json',
      'Authorization': token,
    };
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      return Transactions.fromJson(json.decode(response.body));
    } else {
      throw Exception("Something Error");
    }
  }

  Future<TransactionsDetail> getTransactionDetail(id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString("token").toString();
    String url = "$base_url$listTransactions$id$detail";
    var headers = {
      'Accept': 'application/json',
      'Authorization': token,
    };
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return TransactionsDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception("Something Error");
    }
  }
}
