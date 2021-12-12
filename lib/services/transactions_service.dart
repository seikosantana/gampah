import 'dart:convert';

import 'package:gampah_app/models/model_transactions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransactionsService {
  String base_url = 'https://shamo.tanpabatasgroup.com/api/';
  String transactions = 'transactions';
  String listTransactions = 'transactions/';

  Future<Map<String, dynamic>> addTransaction(
    int reporterId,
    String addressDetail,
    String status,
    double latitude,
    double longitude,
    String image,
  ) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = await localStorage.getString("token").toString();
    var url = "$base_url$transactions";
    var header = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8',
      'Authorization': token
    };
    var request = await http.MultipartRequest('POST', Uri.parse(url));
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

  Future<Transactions> allTransactionsByToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = await localStorage.getString("token").toString();
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
}
