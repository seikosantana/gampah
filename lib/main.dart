import 'package:flutter/material.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/error/error.dart';
import 'package:gampah_app/ui/error/error_gps.dart';
import 'package:gampah_app/ui/pages/page_about.dart';
import 'package:gampah_app/ui/pages/page_get_started.dart';
import 'package:gampah_app/ui/pages/page_home.dart';
import 'package:gampah_app/ui/pages/page_login.dart';
import 'package:gampah_app/ui/pages/page_register.dart';
import 'package:gampah_app/ui/pages/page_splash.dart';
import 'package:gampah_app/ui/pages/page_test_widget.dart';
import 'package:gampah_app/ui/pages/page_transaction.dart';
import 'package:gampah_app/ui/pages/page_transaction_register.dart';
import 'package:gampah_app/ui/pages/page_tutorial.dart';

void main() => runApp(TestPage());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gampah",
      theme: ThemeData(textTheme: myTexTheme),
      home: GetStartedPage(),
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => SplashPage(),
        GetStartedPage.routeName: (context) => GetStartedPage(),
        HomePage.routeName: (context) => HomePage(),
        LoginPage.routeName: (context) => LoginPage(),
        RegisterPage.routeName: (context) => RegisterPage(),
        RegisterTransaction.routeName: (context) => RegisterTransaction(),
        TransactionPage.routeName: (context) => TransactionPage(),
        AboutPage.routeName: (context) => AboutPage(),
        TutorialPage.routeName: (context) => TutorialPage(),
        ErrorPage.routeName: (context) => ErrorPage(),
        ErrorGpsPage.routeName: (context) => ErrorGpsPage(),
      },
    );
  }
}
