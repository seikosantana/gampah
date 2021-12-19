import 'package:flutter/material.dart';
import 'package:gampah_app/models/model_user.dart';
import 'package:gampah_app/provider/auth_provider.dart';
import 'package:gampah_app/provider/transactions_provider.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/pages/page_home.dart';
import 'package:gampah_app/ui/pages/page_register.dart';
import 'package:gampah_app/ui/pages/page_transaction.dart';
import 'package:gampah_app/ui/widgets/btn_loading.dart';
import 'package:gampah_app/ui/widgets/form_controls/gampah_text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login";
  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

//TODO: Apply colors to icons and text
class LoginPageState extends State<LoginPage> {
  bool isNotHold = true;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleLogin() async {
      setState(() {
        isLoading = true;
      });
      bool result = await authProvider.login(
          emailController.text, passwordController.text);
      UserModel? user = authProvider.getUser;
      print(result);

      if (result) {
        var transactionProviders =
            Provider.of<TransactionProvider>(context, listen: false);
        await transactionProviders.fetchAllData();
        if (user!.roles == 'DRIVER') {
          transactionProviders.startMonitorTransaction();
          // return Navigator.pushReplacementNamed(
          //     context, TransactionPage.routeName);
        }
        return Navigator.pushReplacementNamed(context, HomePage.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: redColor,
            content: Text(
              'Gagal Login!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }

    Widget _btnLoading() {
      return BtnLoading();
    }

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
                style: appTextTheme.headline5!.copyWith(),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Selamat datang kembali",
                style: appTextTheme.subtitle1,
              ),
              Text(
                "Yuk hijaukan bumi",
                style: appTextTheme.subtitle1,
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
                controller: emailController,
              ),
              SizedBox(
                height: 24,
              ),
              GampahTextField(
                labelText: "Kata sandi",
                prefix: Icon(Icons.lock, color: softGreyColor),
                postAction: IconButton(
                  splashColor: Colors.transparent,
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
                maskText: isNotHold,
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: isLoading == true
                        ? _btnLoading()
                        : ElevatedButton(
                            onPressed: handleLogin,
                            child: Text(
                              "Masuk",
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
              SizedBox(
                height: 8,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegisterPage.routeName);
                },
                child: RichText(
                  text: TextSpan(
                    style: appTextTheme.bodyText2,
                    children: <TextSpan>[
                      TextSpan(
                        text: "Belum punya akun? ",
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
    );
  }
}
