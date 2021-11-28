import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/pages/page_register.dart';
import 'package:gampah_app/ui/widgets/form_controls/gampah_text_field.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login";
  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

//TODO: Apply colors to icons and text
class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(24),
          margin: EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Masuk",
                style: myTexTheme.headline5!.copyWith(),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Selamat datang kembali",
                style: myTexTheme.subtitle1,
              ),
              Text(
                "Yuk hijaukan bumi",
                style: myTexTheme.subtitle1,
              ),
              SizedBox(
                height: 40,
              ),
              GampahTextField(
                prefix: Icon(
                  Icons.email,
                  color: softGreyColor,
                ),
                labelText: "Email kamu",
              ),
              SizedBox(
                height: 24,
              ),
              GampahTextField(
                labelText: "Kata sandi",
                prefix: Icon(Icons.lock, color: softGreyColor),
                postAction: IconButton(
                  icon: Icon(
                    Icons.visibility_off,
                    color: softGreyColor,
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      // TODO: Replace with Gampah-themed button
                      onPressed: () {},
                      child: Text(
                        "Masuk",
                        style: myTexTheme.button,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        primary: softGreenColor,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegisterPage.routeName);
                },
                child: RichText(
                  text: TextSpan(
                    style: myTexTheme.bodyText2,
                    children: <TextSpan>[
                      TextSpan(
                        text: "Belum punya akun? ",
                      ),
                      TextSpan(
                        text: " Yuk daftar",
                        style: myTexTheme.bodyText2!
                            .copyWith(color: softBlueColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
