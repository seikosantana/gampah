import 'package:flutter/cupertino.dart';
import 'package:gampah_app/services/transactions_service.dart';

class TransactionProvider with ChangeNotifier {
  Future<bool> addTransaction(
    int reporterId,
    String addressDetail,
    String status,
    double latitude,
    double longitude,
    String image,
  ) async {
    try {
      await TransactionsService().addTransaction(
        reporterId,
        addressDetail,
        status,
        latitude,
        longitude,
        image,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
