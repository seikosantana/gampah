import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gampah_app/models/model_transactions_detail.dart';
import 'package:gampah_app/services/transactions_service.dart';

enum ResultState { loading, nodata, hasData, error }

class TransactionProvider with ChangeNotifier {
  final TransactionsService transactionsService;
  TransactionProvider(
      {required this.transactionsService,
      required this.newTransactionCallback}) {
    fetchAllData();
  }
  late List _transactions;
  late ResultState _state;
  String _message = '';
  Future Function() newTransactionCallback;
  var _transactionsDetail = null;

  TransactionDetailData? get transactionsDetail => _transactionsDetail;
  List get transactions => _transactions;
  ResultState get state => _state;
  String get message => _message;

  Timer? monitorTimer;

  void startMonitorTransaction() {
    monitorTimer?.cancel();
    monitorTimer = Timer.periodic(Duration(seconds: 5), (t) async {
      try {
        final newList = await transactionsService.allTransactionsByToken();
        if (transactions != null && transactions.length != 0) {
          if (transactions.length != newList.transactionsList.length) {
            newTransactionCallback();
            _transactions = newList.transactionsList;
          }
        }
      } catch (err) {
        print(err);
      }
    });
  }

  void stopMonitorTransaction() {
    monitorTimer?.cancel();
    monitorTimer = null;
  }

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

  Future<bool> updateTransactions(int id, String path, String image) async {
    try {
      await TransactionsService().updateTransaction(
        id,
        path,
        image,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> fetchAllData() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await transactionsService.allTransactionsByToken();
      print(result);
      if (result.transactionsList.isEmpty) {
        _state = ResultState.nodata;
        notifyListeners();
        return _message =
            "Transaksimu masih kosong\nayo buat transaksi untuk hijaukan Bumi!";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _transactions = result.transactionsList;
      }
    } on Exception catch (e) {
      _state = ResultState.error;
      print(e);
      notifyListeners();
      return _message = "Sepertinya kamu mengalami\ngangguan internet!";
    }
  }

  Future<dynamic> fetchDetailTransactions(transactionId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final transactionsDetailResult =
          await transactionsService.getTransactionDetail(transactionId);
      print("ini transaksi detail $transactionsDetailResult");
      if (transactionsDetailResult.transactionDetailData == null) {
        _state = ResultState.nodata;
        notifyListeners();
        return _message = "Tidak ada data yang tersedia dalam sistem";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _transactionsDetail =
            transactionsDetailResult.transactionDetailData;
      }
    } on Exception catch (e) {
      _state = ResultState.error;
      notifyListeners();
      print(e);
      return _message = "Sepertinya kamu mengalami\ngangguan internet!";
    }
  }
}
