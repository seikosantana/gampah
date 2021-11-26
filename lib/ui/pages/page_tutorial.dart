import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/widgets/widget_card_tutorial.dart';
import 'package:gampah_app/ui/widgets/widget_toolbar.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({Key? key}) : super(key: key);
  static const routeName = "/tutorial";

  Widget _toolbar() {
    return CustomToolbar(title: "Cara Pakai");
  }

  Widget _cardTutorial(BuildContext context) {
    return Column(
      children: [
        CardTutorial(
            number: "1",
            title: "Tekan tombol “foto” di halaman Home.",
            image: "assets/tutorial_1.png"),
        CardTutorial(
            number: "2",
            title:
                "Input detail lokasi (opsional) dan arahkan\nkamera pada sampah, lalu tekan “laporkan”.",
            image: "assets/tutorial_2.png"),
        CardTutorial(
            number: "3",
            title:
                "Tinggal tunggu umpan balik dari kami,\nlihat di halaman Transaksi.",
            image: "assets/tutorial_3.png"),
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
            children: [_toolbar(), _cardTutorial(context)],
          ),
        ),
      ),
    );
  }
}
