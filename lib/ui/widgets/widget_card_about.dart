import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';

class CardAbout extends StatelessWidget {
  final String picture;
  final String title;
  final Function()? onTap;
  const CardAbout(
      {Key? key, required this.picture, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.width * 0.5,
        width: MediaQuery.of(context).size.width * 0.36,
        padding: EdgeInsets.fromLTRB(8, 24, 8, 24),
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(image: AssetImage(picture), fit: BoxFit.cover),
        ),
        child: Text(
          title,
          style: appTextTheme.bodyText1!.copyWith(color: whiteColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
