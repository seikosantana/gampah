import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/widgets/form_controls/gampah_drop_down.dart';
import 'package:gampah_app/ui/widgets/form_controls/gampah_text_field.dart';
import 'package:gampah_app/helper_functions.dart/extensions.dart';

class RegisterPage extends StatefulWidget {
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
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Daftar",
              style: myTexTheme.headline5!.copyWith(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Dengan mendaftar kamu bisa selamatkan beruang kutub",
              style: myTexTheme.subtitle1,
            ),
            SizedBox(
              height: 40,
            ),
            GampahTextField(
              labelText: "Nama Kamu",
              prefix: Icon(Icons.person),
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
              prefix: Icon(Icons.mail),
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
              prefix: Icon(Icons.people),
            ),
            SizedBox(
              height: 24,
            ),
            GampahTextField(
              //TODO: Implement visibility toggle
              labelText: "Password",
              maskText: true,
              prefix: Icon(Icons.lock),
              postAction: IconButton(
                icon: Icon(Icons.visibility),
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
          ],
        ),
      ),
    );
  }
}
