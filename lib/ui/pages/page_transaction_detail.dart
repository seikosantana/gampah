// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gampah_app/models/model_transactions.dart';
import 'package:gampah_app/models/model_user.dart';
import 'package:gampah_app/provider/auth_provider.dart';
import 'package:gampah_app/provider/transactions_provider.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/error/success_transaction.dart';
import 'package:gampah_app/ui/widgets/widget_toolbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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

  static var dateFormat = DateFormat("dd MMMM yyyy HH:mm");
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TransactionProvider>(context, listen: false)
            .fetchDetailTransactions(widget.transactionList.id));
  }

  Widget _customButton(Function() handle) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
        child: isLoading
            ? CircularProgressIndicator(
                color: whiteColor,
              )
            : Center(
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
        return softGreyColor;
      case 'DITINJAU':
        return yellowColor;
      case 'DIJEMPUT':
        return softGreenColor;
      default:
        return yellowColor;
    }
  }

  Widget imageDetailOfDialog(String? image) {
    return Container(
      height: 300,
      width: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://shamo.tanpabatasgroup.com/storage/uploads/$image"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    handleTransactions() async {
                      setState(() {
                        isLoading = true;
                      });
                      if (transactionsDetail!.picked_image == null) {
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
                      setState(() {
                        isLoading = false;
                      });
                    }

                    return Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Chip(
                                label: Text(
                                  transactionsDetail!.status,
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
                                  dateFormat.format(DateTime.parse(
                                    transactionsDetail.created_at,
                                  ).toLocal()),
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
                                        dateFormat.format(DateTime.parse(
                                          transactionsDetail.updated_at,
                                        ).toLocal()),
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
                            onTap: () async {
                              await showDialog(
                                context: context,
                                builder: (_) => imageDetailOfDialog(
                                    transactionsDetail.report_image),
                              );
                            },
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
                                  onTap: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (_) => imageDetailOfDialog(
                                          transactionsDetail.picked_image),
                                    );
                                  },
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
                                      onTap: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (_) => imageDetailOfDialog(
                                              transactionsDetail
                                                  .finished_image),
                                        );
                                      },
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
                                  ? _customButton(() => image == null
                                      ? ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          SnackBar(
                                            backgroundColor: redColor,
                                            content: Text(
                                              'Ambil foto dulu!',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )
                                      : handleTransactions())
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
