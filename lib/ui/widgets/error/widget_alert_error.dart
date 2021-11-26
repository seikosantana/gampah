import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:lottie/lottie.dart';

class AlertError extends StatelessWidget {
  final String title;
  final String lottie;
  const AlertError({Key? key, required this.title, required this.lottie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(lottie),
          Text(
            title,
            textAlign: TextAlign.center,
            style: myTexTheme.headline6,
          ),
          SizedBox(
            height: 24,
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Wrap(
                children: [
                  Icon(
                    Icons.keyboard_backspace,
                    color: darkGreenColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Kembali",
                    style: myTexTheme.subtitle1,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
