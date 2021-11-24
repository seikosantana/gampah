import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Kotak Temu",
      theme: ThemeData(
        textTheme: myTexTheme,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: darkGreenColor,
        ),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Gampah juara",
                style: myTexTheme.headline5,
              ),
              Text(
                "Gampah juara",
                style: myTexTheme.headline6,
              ),
              Text(
                "Gampah juara",
                style: myTexTheme.subtitle1,
              ),
              Text(
                "Gampah juara",
                style: myTexTheme.bodyText1,
              ),
              Text(
                "Gampah juara",
                style: myTexTheme.bodyText2,
              ),
              Text(
                "Gampah juara",
                style: myTexTheme.caption,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "masuk",
                    style: myTexTheme.button,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
