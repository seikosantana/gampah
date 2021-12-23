import 'package:flutter/material.dart';
import 'package:gampah_app/models/model_user.dart';
import 'package:gampah_app/provider/auth_provider.dart';
import 'package:gampah_app/services/stats_services.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/pages/page_login.dart';
import 'package:gampah_app/ui/widgets/btn_loading.dart';
import 'package:gampah_app/ui/widgets/form_controls/gampah_text_field.dart';
import 'package:gampah_app/ui/widgets/wiget_circular_image.dart';
import 'package:provider/provider.dart';

class PageProfile extends StatefulWidget {
  static const routeName = "/profile";

  const PageProfile({Key? key}) : super(key: key);

  @override
  PageProfileState createState() {
    return PageProfileState();
  }
}

class PageProfileState extends State<PageProfile> {
  bool isLoading = false;
  Widget _btnLoading() {
    return BtnLoading();
  }

  StatServices statServices = StatServices();

  _rewardContribution(String role, int id) {
    return InkWell(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: redColor,
          content: Text(
            'Sementara Hadiah Belum Dapat Dicairkan!',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 24),
        child: FutureBuilder<double?>(
          future: statServices.getRewardUser(role, id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hadiah Kontribusi"),
                  Row(
                    children: [
                      Text(
                        "${snapshot.data}",
                        style: appTextTheme.bodyText1!
                            .copyWith(color: darkGreyColor),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        "BTC",
                        style: appTextTheme.bodyText2!
                            .copyWith(color: softGreyColor),
                      ),
                      Image.asset(
                        "assets/btc.png",
                        width: 25,
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hadiah Kontribusi"),
                  Row(
                    children: [
                      CircularProgressIndicator(
                        color: darkGreenColor,
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        "BTC",
                        style: appTextTheme.bodyText2!
                            .copyWith(color: softGreyColor),
                      ),
                      Image.asset(
                        "assets/btc.png",
                        width: 25,
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.getUser;
    handleLogout() async {
      setState(() {
        isLoading = true;
      });
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
      setState(() {
        isLoading = false;
      });
    }

    Widget _profile() {
      return Column(
        children: [
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
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                _rewardContribution(user!.roles, user.id),
                SizedBox(height: 16),
                _profile(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
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
                            child: isLoading
                                ? _btnLoading()
                                : ElevatedButton(
                                    onPressed: handleLogout,
                                    child: Text(
                                      "Keluar",
                                      style: appTextTheme.button,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 14),
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
    );
  }
}
