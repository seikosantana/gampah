import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/widgets/form_controls/gampah_text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

//TODO: Apply colors to icons and text
class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
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
            labelText: "Email kamu",
          ),
          SizedBox(
            height: 24,
          ),
          GampahTextField(
            labelText: "Kata sandi",
            prefix: Icon(Icons.lock),
            postAction: IconButton(
              icon: Icon(Icons.visibility_off),
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
            height: 24,
          ),
          Text("Belum punya akun? Yuk daftar"),
        ],
      ),
    );
  }
}
