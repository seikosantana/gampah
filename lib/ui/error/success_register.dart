import 'package:flutter/material.dart';
import 'package:gampah_app/ui/widgets/error/widget_alert_error.dart';

class RegisterSuccess extends StatelessWidget {
  const RegisterSuccess({Key? key}) : super(key: key);
  static const routeName = '/transaction_success';
  Widget _itemAlert() {
    return AlertError(
        title: "Yeay! Selamat Akunmu Sudah Terdaftar\nSilahkan Login",
        lottie: "assets/transaction_success.json");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _itemAlert());
  }
}
