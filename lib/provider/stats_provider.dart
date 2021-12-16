import 'package:flutter/cupertino.dart';
import 'package:gampah_app/provider/transactions_provider.dart';
import 'package:gampah_app/services/stats_services.dart';

class StatsProvider with ChangeNotifier {
  Future? dataLoad;

  int? driverCount, contributorsCount, pickUpCount;
  String? errorMessage;
  StatServices statServices;

  StatsProvider({required this.statServices});

  void getStats() {
    Future<int?> getDriverFuture = statServices.getDriversCount();
    Future<int?> getContributorFuture = statServices.getContributors();
    Future<int?> getPickupFuture = statServices.getFinishedTransactions();
    dataLoad =
        Future.wait([getContributorFuture, getDriverFuture, getPickupFuture])
            .then((List<int?> value) {
      contributorsCount = value[0];
      driverCount = value[1];
      pickUpCount = value[2];
      notifyListeners();
    }).catchError((err) {
      errorMessage = "Unable to get statistics";
      notifyListeners();
    });
  }
}
