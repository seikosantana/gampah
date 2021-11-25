import 'package:flutter/material.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/pages/page_get_started.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gampah",
      theme: ThemeData(textTheme: myTexTheme),
      home: GetStartedPage(),
    );
  }
}
