import 'dart:io';

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
import 'package:gampah_app/ui/error/success_transaction.dart';
import 'package:gampah_app/ui/widgets/widget_toolbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
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
  File? image;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TransactionProvider>(context, listen: false)
            .fetchDetailTransactions(widget.transactionList.id));
  }

  Widget _customButton(Function() handle) {
    return Container(
      height: 50,
      child: ElevatedButton(
        onPressed: handle,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(darkGreenColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        child: Center(
          child: Text(
            "Perbaharui Tinjauan",
            style: appTextTheme.button,
          ),
        ),
      ),
    );
  }

  Color _colorOfStatus(String status) {
    switch (status) {
      case 'PENDING':
        return yellowColor;
      case 'DITINJAU':
        return softGreyColor;
      case 'DIJEMPUT':
        return softGreenColor;
      default:
        return yellowColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.transactionList.id);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
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
                  } else if (state.state == ResultState.hasData &&
                      state.transactionsDetail != null) {
                    final transactionsDetail = state.transactionsDetail;
                    var path;
                    print("instanse Of $transactionsDetail");
                    print("Report Image ${transactionsDetail!.report_image}");
                    print("Picked Image ${transactionsDetail.picked_image}");

                    handleTransactions() async {
                      if (transactionsDetail.picked_image == null) {
                        path = "observation_img";
                      } else {
                        path = "cleanup_img";
                      }
                      bool result =
                          await transactionProvider.updateTransactions(
                        transactionsDetail.id,
                        path,
                        image!.path,
                      );
                      if (result) {
                        transactionProvider.fetchAllData();
                        return Navigator.pushReplacementNamed(
                            context, TransactionSuccess.routeName);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: redColor,
                            content: Text(
                              'Transaksi Gagal diperbaharui!',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    }

                    return Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Chip(
                                label: Text(
                                  transactionsDetail.status,
                                  style: appTextTheme.caption!
                                      .copyWith(color: whiteColor),
                                ),
                                backgroundColor:
                                    _colorOfStatus(transactionsDetail.status),
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
                              Text("Bukti peninjauan",
                                  style: appTextTheme.bodyText1!
                                      .copyWith(color: darkGreyColor)),
                            ],
                          ),
                          transactionsDetail.picked_image == null
                              ? user.roles == 'DRIVER'
                                  ? InkWell(
                                      onTap: () => pickImage(),
                                      child: image != null
                                          ? Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 16),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(17),
                                                child: Image.file(
                                                  image!,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 300,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 200,
                                              margin: EdgeInsets.only(
                                                  top: 8, bottom: 16),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: softWhiteColor,
                                              ),
                                              child: Center(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.camera_alt,
                                                    color: softGreyColor,
                                                  ),
                                                  Text("Ambil Foto")
                                                ],
                                              )),
                                            ),
                                    )
                                  : Column(
                                      children: [
                                        Lottie.asset('assets/driver.json',
                                            width: 230),
                                        Text("Menunggu Ditinjau Driver")
                                      ],
                                    )
                              : InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://shamo.tanpabatasgroup.com/storage/uploads/${transactionsDetail.picked_image}"),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 24,
                          ),
                          transactionsDetail.picked_image == null
                              ? Container()
                              : Row(
                                  children: [
                                    Text("Bukti pembersihan",
                                        style: appTextTheme.bodyText1!
                                            .copyWith(color: darkGreyColor)),
                                  ],
                                ),
                          transactionsDetail.picked_image == null
                              ? Container()
                              : transactionsDetail.finished_image == null
                                  ? user.roles == 'DRIVER'
                                      ? InkWell(
                                          onTap: () => pickImage(),
                                          child: image != null
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 16),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            17),
                                                    child: Image.file(
                                                      image!,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 300,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 200,
                                                  margin: EdgeInsets.only(
                                                      top: 16, bottom: 8),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: softWhiteColor,
                                                  ),
                                                  child: Center(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.camera_alt,
                                                        color: softGreyColor,
                                                      ),
                                                      Text("Ambil Foto")
                                                    ],
                                                  )),
                                                ),
                                        )
                                      : Column(
                                          children: [
                                            Lottie.asset('assets/driver.json',
                                                width: 230),
                                            Text("Menunggu Driver Menjemput")
                                          ],
                                        )
                                  : InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://shamo.tanpabatasgroup.com/storage/uploads/${transactionsDetail.finished_image}"),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                          transactionsDetail.finished_image == null
                              ? user.roles == 'DRIVER'
                                  ? _customButton(() => handleTransactions())
                                  : Container()
                              : Container(),
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
