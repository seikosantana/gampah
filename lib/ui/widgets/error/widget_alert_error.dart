import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:lottie/lottie.dart';

class AlertError extends StatelessWidget {
  final String title;
  final String lottie;
  final Function()? ontap;
  const AlertError(
      {Key? key, required this.title, required this.lottie, this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(lottie),
            Text(
              title,
              textAlign: TextAlign.center,
              style: appTextTheme.headline6,
            ),
            SizedBox(
              height: 24,
            ),
            TextButton(
              onPressed: ontap == null
                  ? () {
                      Navigator.pop(context);
                    }
                  : ontap,
              child: Center(
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
                      style: appTextTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
