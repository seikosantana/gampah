import 'package:flutter/material.dart';
import 'package:gampah_app/provider/auth_provider.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/error/success_register.dart';
import 'package:gampah_app/ui/widgets/form_controls/gampah_drop_down.dart';
import 'package:gampah_app/ui/widgets/form_controls/gampah_text_field.dart';
import 'package:gampah_app/helper_functions.dart/extensions.dart';
import 'package:provider/provider.dart';

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
  bool isNotHold = true;
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    handleRegister() async {
      bool result = await authProvider.register(
        nameController.text,
        phoneController.text,
        emailController.text,
        registerAs,
        passwordController.text,
      );
      print(result);
      if (result) {
        return Navigator.pushReplacementNamed(
            context, RegisterSuccess.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: redColor,
            content: Text(
              'Gagal Register!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

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
                  controller: nameController,
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
                  controller: phoneController,
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
                  controller: emailController,
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
                  maskText: isNotHold,
                  prefix: Icon(
                    Icons.lock,
                    color: softGreyColor,
                  ),
                  postAction: IconButton(
                    icon: Icon(
                      isNotHold ? Icons.visibility_off : Icons.visibility,
                      color: isNotHold ? softGreyColor : darkGreenColor,
                    ),
                    onPressed: () {
                      setState(() {
                        isNotHold = !isNotHold;
                      });
                    },
                  ),
                  controller: passwordController,
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        // TODO: Replace with Gampah-themed button
                        onPressed: handleRegister,
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
                          text: " Yuk login",
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
