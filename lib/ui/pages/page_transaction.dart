import 'package:flutter/material.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);
  static const routeName = "/transaction";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Halaman transaksi yang di isi oleh seiko nantinya"),
      ),
    );
  }
}
