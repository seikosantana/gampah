import 'package:flutter/material.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/pages/page_get_started.dart';
import 'package:gampah_app/ui/pages/page_home.dart';
import 'package:gampah_app/ui/pages/page_test_widget.dart';

void main() => runApp(TestPage()); //TODO: change to MyApp on production-ready

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gampah",
      theme: ThemeData(textTheme: myTexTheme),
      home: GetStartedPage(),
      routes: {
        GetStartedPage.routeName: (context) => GetStartedPage(),
        HomePage.routeName: (context) => HomePage(),
      },
    );
  }
}
