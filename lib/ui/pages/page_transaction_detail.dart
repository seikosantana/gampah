import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/widgets/widget_toolbar.dart';

class TransactionDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransactionDetailPageState();
  }
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: darkGreenColor,
        child: Icon(Icons.location_on),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                CustomToolbar(title: "Detail Transaksi"),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Chip(
                            label: Text("Status"),
                          )
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Tanggal Permintaan Jemput",
                              style: myTexTheme.bodyText2,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "19 Desember 2021, 15:48 WIB",
                              style: myTexTheme.bodyText2!
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
                              style: myTexTheme.bodyText2,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Proses penjemputan",
                              style: myTexTheme.bodyText2!
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
                              style: myTexTheme.bodyText2,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Jl. Hiroshima Naga No. 9, Bogor, Jawa Barat",
                              style: myTexTheme.bodyText2!
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
                              style: myTexTheme.bodyText1!
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
                          color: softWhiteColor,
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
                                  style: myTexTheme.bodyText2,
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
                          Text("Bukti pengangkutan",
                              style: myTexTheme.bodyText1!
                                  .copyWith(color: darkGreyColor)),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 200,
                          color: softWhiteColor,
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
                                  style: myTexTheme.bodyText2,
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
                              style: myTexTheme.bodyText1!
                                  .copyWith(color: darkGreyColor)),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 200,
                          color: softWhiteColor,
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
                                  style: myTexTheme.bodyText2,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}