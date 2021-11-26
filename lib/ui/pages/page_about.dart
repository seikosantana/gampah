import 'package:flutter/material.dart';
import 'package:gampah_app/ui/widgets/widget_toolbar.dart';
import 'package:gampah_app/ui/widgets/widget_card_item_about.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);
  static const routeName = "/about";
  Widget _toolbar() {
    return CustomToolbar(title: "Gampah");
  }

  Widget _cardAbout() {
    return Column(
      children: [
        CardItemAbout(
            title: "Buang Sampah Lebih\nMudah",
            description:
                "Tinggal laporin aja sampah kamu, biar tim\nkami yang buang sampahnya.",
            image: "assets/about_1.svg"),
        CardItemAbout(
            title: "Laporin Sampah Sembarangan",
            description: "Jangan sampai lingkungan\nkita ada sampahnya",
            image: "assets/about_2.svg"),
        CardItemAbout(
            title: "Yuk Buang sampah\ndengan Gampah",
            description: "Pokonya ada sampah langsung\nGampah-in",
            image: "assets/about_1.svg")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_toolbar(), _cardAbout()],
            ),
          ),
        ),
      ),
    );
  }
}
