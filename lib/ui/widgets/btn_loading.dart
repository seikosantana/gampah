import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';

class BtnLoading extends StatelessWidget {
  const BtnLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: CircularProgressIndicator(
        color: whiteColor,
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14),
        primary: softGreenColor,
      ),
    );
  }
}
