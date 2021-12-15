import 'package:flutter/material.dart';
import 'package:gampah_app/models/model_user.dart';
import 'package:gampah_app/provider/auth_provider.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/pages/page_login.dart';
import 'package:gampah_app/ui/widgets/form_controls/gampah_text_field.dart';
import 'package:gampah_app/ui/widgets/widget_toolbar.dart';
import 'package:gampah_app/ui/widgets/wiget_circular_image.dart';
import 'package:provider/provider.dart';

class PageProfile extends StatefulWidget {
  static const routeName = "/profile";

  @override
  PageProfileState createState() {
    return PageProfileState();
  }
}

class PageProfileState extends State<PageProfile> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.getUser;
    handleLogout() async {
      bool result = await authProvider.logout();
      if (result) {
        Navigator.pushNamedAndRemoveUntil(
            context, LoginPage.routeName, (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: redColor,
            content: Text(
              'Gagal Keluar!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Expanded(
              child: Column(
                children: [
                  CustomToolbar(
                    title: "Profil",
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  CircularImage(
                    image: AssetImage("assets/image_profile.png"),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Chip(
                    label: Text(
                      user!.roles,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: softGreenColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 16,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      children: [
                        GampahTextField(
                          labelText: "Nama kamu",
                          prefix: Icon(
                            Icons.person_rounded,
                            color: softGreyColor,
                          ),
                          hintText:
                              "${user.name[0].toUpperCase()}${user.name.substring(1)}",
                          isEnable: false,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        GampahTextField(
                          labelText: "Nomor HP",
                          prefix: Text("+62"),
                          hintText: user.phone,
                          isEnable: false,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        GampahTextField(
                          labelText: "Email kamu",
                          prefix: Icon(
                            Icons.mail,
                            color: softGreyColor,
                          ),
                          hintText: user.email,
                          isEnable: false,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                // TODO: Replace with Gampah-themed button
                                onPressed: handleLogout,
                                child: Text(
                                  "Keluar",
                                  style: appTextTheme.button,
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  primary: softGreenColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
