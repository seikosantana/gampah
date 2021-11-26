import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/widgets/widget_card_item_transaction.dart';
import 'package:gampah_app/ui/widgets/widget_toolbar.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);
  static const routeName = "/transaction";

  Widget _toolbar() {
    return CustomToolbar(title: "Transaksi");
  }

  Widget _textHeader() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Text(
        "Transaksimu\nmenyelamatkan bumi\ndari sampah.",
        style: myTexTheme.headline6!.copyWith(color: softGreenColor),
      ),
    );
  }

  Widget _cardTransaction(BuildContext context) {
    return Column(
      children: [
        CardTransaction(
            date: "16 Desember 2021",
            name: "Bijantium Sinatria ksjfkdfkasjd",
            status: "Berhasil",
            color: darkGreenColor,
            address: "Jl Hirosima Naga Saki No 9 Bogor barat"),
        CardTransaction(
            date: "16 Desember 2021",
            name: "Bijantium Sinatria ksjfkdfkasjd",
            status: "Berhasil",
            color: darkGreenColor,
            address: "Jl Hirosima Naga Saki No 9 Bogor barat"),
        CardTransaction(
            date: "16 Desember 2021",
            name: "Bijantium Sinatria ksjfkdfkasjd",
            status: "Berhasil",
            color: darkGreenColor,
            address: "Jl Hirosima Naga Saki No 9 Bogor barat"),
        CardTransaction(
            date: "16 Desember 2021",
            name: "Bijantium Sinatria ksjfkdfkasjd",
            status: "Berhasil",
            color: darkGreenColor,
            address: "Jl Hirosima Naga Saki No 9 Bogor barat"),
        CardTransaction(
            date: "16 Desember 2021",
            name: "Bijantium Sinatria ksjfkdfkasjd",
            status: "Berhasil",
            color: darkGreenColor,
            address: "Jl Hirosima Naga Saki No 9 Bogor barat"),
        CardTransaction(
            date: "16 Desember 2021",
            name: "Bijantium Sinatria ksjfkdfkasjd",
            status: "Berhasil",
            color: darkGreenColor,
            address: "Jl Hirosima Naga Saki No 9 Bogor barat"),
        CardTransaction(
            date: "16 Desember 2021",
            name: "Bijantium Sinatria ksjfkdfkasjd",
            status: "Berhasil",
            color: darkGreenColor,
            address: "Jl Hirosima Naga Saki No 9 Bogor barat"),
        CardTransaction(
            date: "16 Desember 2021",
            name: "Bijantium Sinatria ksjfkdfkasjd",
            status: "Berhasil",
            color: darkGreenColor,
            address: "Jl Hirosima Naga Saki No 9 Bogor barat"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_toolbar(), _textHeader(), _cardTransaction(context)],
        ),
      ),
    ));
  }
}
