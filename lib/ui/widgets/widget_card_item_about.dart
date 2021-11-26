import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gampah_app/style/text_theme.dart';

class CardItemAbout extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  const CardItemAbout(
      {Key? key,
      required this.title,
      required this.description,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 0, 24, 16),
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Center(
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: myTexTheme.subtitle1,
                ),
                SizedBox(
                  height: 16,
                ),
                SvgPicture.asset(image),
                SizedBox(
                  height: 16,
                ),
                Text(
                  description,
                  style: myTexTheme.bodyText2,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
