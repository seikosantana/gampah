import 'package:flutter/material.dart';
import 'package:gampah_app/ui/widgets/error/widget_alert_error.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);
  static const routeName = '/error';
  Widget _itemAlert() {
    return AlertError(
        title: "Terjadi Kesalahan,\nSilahkan Coba Kembali\nLain Waktu.",
        lottie: "assets/alert_error.json");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _itemAlert(),
    );
  }
}
