import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';

class CardTutorial extends StatelessWidget {
  final String title;
  final String number;
  final String image;
  const CardTutorial(
      {Key? key,
      required this.number,
      required this.title,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 280,
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: whiteColor,
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 30,
              width: 40,
              decoration: BoxDecoration(
                color: darkGreenColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Text(number,
                    style: myTexTheme.bodyText1!.copyWith(color: whiteColor)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 56, top: 6),
            child: Text(
              title,
              style: myTexTheme.bodyText2!.copyWith(color: darkGreyColor),
            ),
          )
        ],
      ),
    );
  }
}
