import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/widgets/widget_card_about.dart';
import 'package:gampah_app/ui/widgets/widget_card_activity.dart';
import 'package:gampah_app/ui/widgets/widget_clip_path.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home_page';

  Widget _clipPath(BuildContext context) {
    return ClipPath(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        color: softGreenColor,
      ),
      clipper: CustomClipPath(),
    );
  }

  Widget _header() {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hai, Bijantium",
                  style: myTexTheme.headline5!.copyWith(color: whiteColor),
                ),
                Text(
                  "Yuk Laporin Sampahnya",
                  style: myTexTheme.subtitle1!.copyWith(color: whiteColor),
                ),
              ],
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: whiteColor,
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/image_profile.png"),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _titleActivity() {
    return Container(
      margin: EdgeInsets.only(left: 24, top: 165),
      child: Text(
        "Aktivitas Gampah",
        style: myTexTheme.headline6,
      ),
    );
  }

  Widget _cardActivity(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            CardActivity(skala: "12", title: "Sampah\nterbuang"),
            CardActivity(skala: "80K", title: "Orang\nberkontribusi"),
            CardActivity(skala: "200", title: "Driver\nyang sigap"),
          ],
        ),
      ),
    );
  }

  Widget _aboutGampah(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kenali Gampah Lebih Dekat",
            style: myTexTheme.headline6,
          ),
          Text(
            "Biar kita makin akrab",
            style: myTexTheme.subtitle2,
          ),
          SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CardAbout(
                    picture: "assets/home_about1.png",
                    title: "Apa itu\nGampah"),
                CardAbout(
                    picture: "assets/home_about2.png",
                    title: "Cara\nPakai Gampah"),
                CardAbout(
                    picture: "assets/home_about3.png",
                    title: "Sudah\nMengertikan\nCara Pakai\nGampah?"),
              ],
            ),
          )
        ],
      ),
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
            children: [
              Stack(
                children: [_clipPath(context), _header(), _titleActivity()],
              ),
              _cardActivity(context),
              _aboutGampah(context)
            ],
          ),
        ),
      ),
    );
  }
}
