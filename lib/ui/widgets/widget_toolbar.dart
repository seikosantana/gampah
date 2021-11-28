import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';

class CustomToolbar extends StatelessWidget {
  final String title;
  const CustomToolbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(14, 16, 24, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_backspace,
              color: darkGreyColor,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            title,
            style: myTexTheme.headline6,
          )
        ],
      ),
    );
  }
}
