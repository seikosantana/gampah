import 'dart:convert';

import 'package:http/http.dart' as http;

class TransactionsService {
  String base_url = 'http://192.168.1.12:8000/api/';
  String transactions = 'transactions';

  Future<Map<String, dynamic>> addTransaction(
    int reporterId,
    String addressDetail,
    String status,
    double latitude,
    double longitude,
    String image,
  ) async {
    var url = "$base_url$transactions";
    var header = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8',
    };
    // var body = jsonEncode({
    //   'reporter_id': reporterId,
    //   'address_detail': addressDetail,
    //   'status': status,
    //   'latitude': latitude,
    //   'longitude': longitude,
    // });

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
}