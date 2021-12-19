import 'package:flutter/material.dart';
import 'package:gampah_app/models/model_user.dart';
import 'package:gampah_app/provider/auth_provider.dart';
import 'package:gampah_app/services/auth_services.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/ui/pages/page_get_started.dart';
import 'package:gampah_app/ui/pages/page_home.dart';
import 'package:gampah_app/ui/pages/page_login.dart';
import 'package:gampah_app/ui/pages/page_transaction.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashPage extends StatelessWidget {
  static const routeName = "/splash";
  final AuthService authService;
  Widget? nextPage;

  SplashPage({required this.authService, Key? key}) : super(key: key);

  Future decideNextPage(BuildContext context) async {
    // var prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    bool isFirstTime = await authService.isFirstTimeUser();
    if (isFirstTime) {
      nextPage = GetStartedPage();
    } else {
      UserModel? user = await authService.getUser();
      if (user == null) {
        nextPage = LoginPage();
      } else {
        AuthProvider authProvider =
            Provider.of<AuthProvider>(context, listen: false);
        authProvider.user = user;

        nextPage = HomePage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SplashScreenView(
            navigateRoute: nextPage,
            duration: 3000,
            imageSize: 100,
            backgroundColor: whiteColor,
            imageSrc: "assets/logo_1.png",
          );
        } else {
          return Container();
        }
      },
      future: decideNextPage(context),
    );
  }
}
