import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/widgets/error/widget_alert_error.dart';
import 'package:geolocator/geolocator.dart';

class ErrorGpsPage extends StatelessWidget {
  const ErrorGpsPage({Key? key}) : super(key: key);
  static const routeName = '/error_gps';
  Widget _itemAlert() {
    return AlertError(
        title: "Kami butuh lokasi kamu\nNyalain GPS yuk!",
        lottie: "assets/alert_gps.json");
  }

  Widget _customButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Geolocator.openLocationSettings();
        },
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
            "Buka pengaturan GPS",
            style: myTexTheme.button,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [_itemAlert(), _customButton()],
        ),
      ),
    );
  }
}
