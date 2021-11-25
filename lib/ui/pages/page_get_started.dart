import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/widgets/btn_next_get_started.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  Widget _btnNext() {
    return BtnNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                "assets/get_started.svg",
                semanticsLabel: 'Get Started',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Laporin sampahnya\nbiar kami yang buang.",
              textAlign: TextAlign.center,
              style: myTexTheme.headline5,
            ),
          ],
        ),
      ),
      bottomSheet: Stack(
        children: [
          SvgPicture.asset(
            "assets/bottom_wave.svg",
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            margin: EdgeInsets.all(24),
            padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Siap\nHijaukan\nKehidupan?",
                    style: myTexTheme.headline5!.copyWith(color: whiteColor),
                  ),
                  _btnNext(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
