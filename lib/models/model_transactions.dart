class Transactions {
  final List<TransactionList> transactionsList;
  Transactions({required this.transactionsList});
  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
      transactionsList: List<TransactionList>.from(
          json["data"].map((x) => TransactionList.fromJson(x))));

  Map<String, dynamic> toJson() =>
      {'data': List<dynamic>.from(transactionsList.map((e) => e.toJson()))};
}

class TransactionList {
  final int id;
  final int reporter_id;
  final int driver_id;
  final String address_detail;
  final String status;
  final String created_at;
  TransactionList({
    required this.id,
    required this.reporter_id,
    required this.driver_id,
    required this.address_detail,
    required this.status,
    required this.created_at,
  });

  factory TransactionList.fromJson(Map<String, dynamic> json) =>
      TransactionList(
        id: json['id'],
        reporter_id: json['reporter_id'],
        driver_id: json['driver_id'],
        address_detail: json['address_detail'],
        status: json['status'],
        created_at: json['created_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'reporter_id': reporter_id,
        'driver_id': driver_id,
        'address_detail': address_detail,
        'status': status,
        'created_at': created_at
      };
}
