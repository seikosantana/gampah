import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/ui/pages/page_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BtnNext extends StatefulWidget {
  const BtnNext({Key? key}) : super(key: key);

  @override
  State<BtnNext> createState() => _BtnNextState();
}

class _BtnNextState extends State<BtnNext> {
  bool isTap = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
        var prefs = await SharedPreferences.getInstance();
        prefs.setBool("is_first", false);
        setState(() {
          isTap = !isTap;
        });
      },
      child: Container(
        height: 45,
        width: 45,
        margin: EdgeInsets.only(top: 48),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isTap ? softGreyColor : whiteColor,
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
