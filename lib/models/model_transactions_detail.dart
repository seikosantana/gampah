import 'package:flutter/material.dart';

class TransactionsDetail {
  final TransactionDetailData transactionDetailData;
  TransactionsDetail({required this.transactionDetailData});
  factory TransactionsDetail.fromJson(Map<String, dynamic> json) =>
      TransactionsDetail(
          transactionDetailData: TransactionDetailData.fromJson(json["data"]));
  Map<String, dynamic> toJson() => {"data": transactionDetailData.toJson()};
}

class TransactionDetailData {
  int id;
  String reporter_id;
  String driver_id;
  String report_image;
  String? picked_image;
  String? finished_image;
  String address_detail;
  String status;
  String latitude;
  String longitude;
  String created_at;
  String updated_at;

  TransactionDetailData({
    required this.id,
    required this.reporter_id,
    required this.driver_id,
    required this.report_image,
    this.picked_image,
    this.finished_image,
    required this.address_detail,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.created_at,
    required this.updated_at,
  });

  factory TransactionDetailData.fromJson(Map<String, dynamic> json) =>
      TransactionDetailData(
        id: json['id'],
        reporter_id: json['reporter_id'],
        driver_id: json['driver_id'],
        report_image: json['report_image'],
        picked_image: json['picked_image'],
        finished_image: json['finished_image'],
        address_detail: json['address_detail'],
        status: json['status'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'reporter_id': reporter_id,
        'driver_id': driver_id,
        'report_image': report_image,
        'picked_image': picked_image,
        'finished_image': finished_image,
        'address_detail': address_detail,
        'status': status,
        'latitude': latitude,
        'longitude': longitude,
        'created_at': created_at,
        'updated_at': updated_at
      };
}
