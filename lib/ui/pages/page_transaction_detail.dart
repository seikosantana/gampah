import 'package:flutter/material.dart';
import 'package:gampah_app/helper_functions.dart/geolocation.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/error/error.dart';
import 'package:gampah_app/ui/error/error_gps.dart';
import 'package:gampah_app/ui/widgets/widget_toolbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_launcher/maps_launcher.dart';

class TransactionDetailPage extends StatefulWidget {
  static const routeName = "/detail_transaction";
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
        onPressed: () async {
          Position? currentPosition =
              await determinePosition(locationNotEnabledCallback: () {
            Navigator.pushNamed(context, ErrorGpsPage.routeName);
          }, permissionDeniedCallback: () {
            Navigator.pushNamed(context, ErrorPage.routeName);
          });
          if (currentPosition != null) {
            MapsLauncher.launchCoordinates(
                currentPosition.latitude, currentPosition.longitude);
            print(currentPosition);
          }
        },
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
                              style: appTextTheme.bodyText2,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "19 Desember 2021, 15:48 WIB",
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
                            child: Text(
                              "Proses penjemputan",
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
                              "Jl. Hiroshima Naga No. 9, Bogor, Jawa Barat",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
