import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';

class CardActivity extends StatelessWidget {
  final String skala;
  final String title;
  const CardActivity({Key? key, required this.skala, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.50,
      width: MediaQuery.of(context).size.width * 0.41,
      margin: EdgeInsets.only(right: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: darkGreenColor, width: 2),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: darkGreenColor),
                child: Center(
                  child: Text(
                    skala,
                    style: appTextTheme.subtitle1!.copyWith(
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              Text(
                title,
                style: appTextTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
