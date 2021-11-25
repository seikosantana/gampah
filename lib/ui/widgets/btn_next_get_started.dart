import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/ui/pages/page_home.dart';

class BtnNext extends StatelessWidget {
  const BtnNext({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      },
      child: Container(
        height: 45,
        width: 45,
        margin: EdgeInsets.only(top: 48),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: whiteColor,
        ),
        child: Center(
          child: Icon(
            Icons.navigate_next,
          ),
        ),
      ),
    );
  }
}
