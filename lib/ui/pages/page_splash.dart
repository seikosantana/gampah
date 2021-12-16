import 'package:flutter/material.dart';
import 'package:gampah_app/provider/auth_provider.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/ui/pages/page_get_started.dart';
import 'package:gampah_app/ui/pages/page_login.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: GetStartedPage(),
      duration: 3000,
      imageSize: 100,
      backgroundColor: whiteColor,
      imageSrc: "assets/logo_1.png",
    );
  }
}
