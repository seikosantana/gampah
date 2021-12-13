import 'package:flutter/material.dart';
import 'package:gampah_app/helper_functions.dart/geolocation.dart';
import 'package:gampah_app/models/model_transactions.dart';
import 'package:gampah_app/models/model_user.dart';
import 'package:gampah_app/provider/auth_provider.dart';
import 'package:gampah_app/provider/transactions_provider.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/error/error.dart';
import 'package:gampah_app/ui/error/error_gps.dart';
import 'package:gampah_app/ui/widgets/widget_toolbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';

class TransactionDetailPage extends StatefulWidget {
  static const routeName = "/detail_transaction";
  final TransactionList transactionList;
  const TransactionDetailPage({required this.transactionList});
  @override
  State<StatefulWidget> createState() {
    return _TransactionDetailPageState();
  }
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TransactionProvider>(context, listen: false)
            .fetchDetailTransactions(widget.transactionList.id));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.transactionList.id);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.getUser;
    bool isDriver = user!.roles == 'DRIVER';
    return Scaffold(
      floatingActionButton: isDriver
          ? FloatingActionButton(
              onPressed: () async {
                if (widget.transactionList.latitude.isNotEmpty &&
                    widget.transactionList.longitude.isNotEmpty) {
                  MapsLauncher.launchCoordinates(
                      double.parse(widget.transactionList.latitude),
                      double.parse(widget.transactionList.longitude));
                  print(
                      "untuk melihat current posisiton ${widget.transactionList.latitude},${widget.transactionList.longitude},");
                }
              },
              backgroundColor: darkGreenColor,
              child: Icon(Icons.location_on),
            )
          : Container(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                CustomToolbar(title: "Detail Transaksi"),
                Consumer<TransactionProvider>(builder: (context, state, _) {
                  if (state.state == ResultState.loading &&
                      state.transactionsDetail == null) {
                    return CircularProgressIndicator(
                      color: darkGreenColor,
                    );
                  } else if (state.state == ResultState.hashData &&
                      state.transactionsDetail != null) {
                    final transactionsDetail = state.transactionsDetail;
                    print("ini lah $transactionsDetail");
                    print(transactionsDetail!.report_image);
                    return Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Chip(
                                label: Text(transactionsDetail.status),
                              )
                            ],
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Tanggal Permintaan Jemput",
                                  style: appTextTheme.bodyText2,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  transactionsDetail.created_at,
                                  style: appTextTheme.bodyText2!
                                      .copyWith(color: darkGreyColor),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Tanggal Dijemput",
                                  style: appTextTheme.bodyText2,
                                ),
                              ),
                              Expanded(
                                child: transactionsDetail.picked_image == null
                                    ? Text(
                                        "Proses penjemputan",
                                        style: appTextTheme.bodyText2!
                                            .copyWith(color: darkGreyColor),
                                      )
                                    : Text(
                                        transactionsDetail.updated_at,
                                        style: appTextTheme.bodyText2!
                                            .copyWith(color: darkGreyColor),
                                      ),
                              )
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Alamat Tambahan",
                                  style: appTextTheme.bodyText2,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  transactionsDetail.address_detail,
                                  style: appTextTheme.bodyText2!
                                      .copyWith(color: darkGreyColor),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text("Bukti Pelaporan Sampah",
                                  style: appTextTheme.bodyText1!
                                      .copyWith(color: darkGreyColor)),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://shamo.tanpabatasgroup.com/storage/uploads/${transactionsDetail.report_image}"),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text("Bukti pengangkutan",
                                  style: appTextTheme.bodyText1!
                                      .copyWith(color: darkGreyColor)),
                            ],
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: softWhiteColor,
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      color: darkGreyColor,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "Ambil foto",
                                      style: appTextTheme.bodyText2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text("Bukti pembersihan",
                                  style: appTextTheme.bodyText1!
                                      .copyWith(color: darkGreyColor)),
                            ],
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: softWhiteColor,
                              ),
                              child: Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      color: darkGreyColor,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "Ambil foto",
                                      style: appTextTheme.bodyText2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state.state == ResultState.nodata) {
                    return Center(child: Text(state.message));
                  } else if (state.state == ResultState.error) {
                    return Center(child: Text(state.message));
                  } else {
                    return Center(
                      child: Text(""),
                    );
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
