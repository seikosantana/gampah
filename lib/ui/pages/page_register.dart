import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/widgets/form_controls/gampah_drop_down.dart';
import 'package:gampah_app/ui/widgets/form_controls/gampah_text_field.dart';
import 'package:gampah_app/helper_functions.dart/extensions.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = "/register";
  @override
  RegisterPageState createState() {
    return RegisterPageState();
  }
}

//TODO: Apply colors to icons and text
class RegisterPageState extends State<RegisterPage> {
  String registerAs = "pengguna";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Daftar",
                  style: appTextTheme.headline5,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Dengan mendaftar kamu bisa selamatkan beruang kutub",
                  style: appTextTheme.subtitle1,
                ),
                SizedBox(
                  height: 40,
                ),
                GampahTextField(
                  labelText: "Nama Kamu",
                  prefix: Icon(
                    Icons.person,
                    color: softGreyColor,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                GampahTextField(
                  // TODO: Allow only number input
                  labelText: "Nomor HP",
                  prefix: Container(
                    child: Text("+62"),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                GampahTextField(
                  labelText: "Email kamu",
                  prefix: Icon(
                    Icons.mail,
                    color: softGreyColor,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                GampahDropDown(
                  items: ["pengguna", "driver"]
                      .map((e) => DropdownMenuItem(
                            child: Text(e.toCapitalized()),
                            value: e,
                          ))
                      .toList(),
                  value: registerAs,
                  onChanged: (String? sebagai) {
                    setState(() {
                      registerAs = sebagai!;
                    });
                  },
                  labelText: "Daftar sebagai",
                  prefix: Icon(
                    Icons.people,
                    color: softGreyColor,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                GampahTextField(
                  //TODO: Implement visibility toggle
                  labelText: "Password",
                  maskText: true,
                  prefix: Icon(
                    Icons.lock,
                    color: softGreyColor,
                  ),
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
                          "Daftar",
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
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: RichText(
                    text: TextSpan(
                      style: appTextTheme.bodyText2,
                      children: <TextSpan>[
                        TextSpan(
                          text: "Sudah punya akun? ",
                        ),
                        TextSpan(
                          text: " Yuk daftar",
                          style: appTextTheme.bodyText2!
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
      ),
    );
  }
}
