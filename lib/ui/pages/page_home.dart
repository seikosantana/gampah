import 'package:flutter/material.dart';
import 'package:gampah_app/models/model_user.dart';
import 'package:gampah_app/provider/auth_provider.dart';
import 'package:gampah_app/provider/stats_provider.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/pages/page_about.dart';
import 'package:gampah_app/ui/pages/page_profile.dart';
import 'package:gampah_app/ui/pages/page_transaction.dart';
import 'package:gampah_app/ui/pages/page_transaction_register.dart';
import 'package:gampah_app/ui/pages/page_tutorial.dart';
import 'package:gampah_app/ui/widgets/widget_card_about.dart';
import 'package:gampah_app/ui/widgets/widget_card_activity.dart';
import 'package:gampah_app/ui/widgets/widget_clip_path.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  Widget _clipPath(BuildContext context) {
    return ClipPath(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        color: softGreenColor,
      ),
      clipper: CustomClipPath(),
    );
  }

  Widget _header(String name) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hai, $name",
                  style: appTextTheme.headline5!.copyWith(color: whiteColor),
                ),
                Text(
                  "Yuk Laporin Sampahnya",
                  style: appTextTheme.subtitle1!.copyWith(color: whiteColor),
                ),
              ],
            ),
          ),
          InkWell(
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/image_profile.png"),
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, PageProfile.routeName);
            },
          ),
        ],
      ),
    );
  }

  Widget _titleActivity() {
    return Container(
      margin: EdgeInsets.only(left: 24, top: 165),
      child: Text(
        "Aktivitas Gampah",
        style: appTextTheme.headline6,
      ),
    );
  }

  static var compactFormat = NumberFormat.compact(locale: "id")
    ..maximumFractionDigits = 1
    ..minimumIntegerDigits = 1;

  Widget _cardActivity(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            Consumer<StatsProvider>(
              builder: (context, value, child) {
                return FutureBuilder(
                  builder: (context, snapshot) {
                    Widget child;
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (!snapshot.hasError) {
                        child = Row(
                          children: [
                            CardActivity(
                                skala: compactFormat.format(value.pickUpCount),
                                title: "Sampah\nterbuang"),
                            CardActivity(
                                skala: compactFormat
                                    .format(value.contributorsCount),
                                title: "Orang\nberkontribusi"),
                            CardActivity(
                                skala: compactFormat.format(value.driverCount),
                                title: "Driver\nyang sigap"),
                          ],
                        );
                      } else {
                        child = Text(
                          value.errorMessage!,
                          style: appTextTheme.bodyText1,
                        );
                      }
                    } else {
                      child = Text(
                        "Para kontributor gampah sedang apa ya?",
                        style: appTextTheme.bodyText1,
                      );
                    }
                    return AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      child: child,
                    );
                  },
                  future: value.dataLoad,
                );
              },
            ),
            // CardActivity(skala: "12", title: "Sampah\nterbuang"),
            // CardActivity(skala: "80K", title: "Orang\nberkontribusi"),
            // CardActivity(skala: "200", title: "Driver\nyang sigap"),
          ],
        ),
      ),
    );
  }

  Widget _titleAbout() {
    return Container(
      margin: EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kenali Gampah Lebih Dekat",
            style: appTextTheme.headline6,
          ),
          Text(
            "Biar kita makin akrab",
            style: appTextTheme.subtitle2,
          ),
        ],
      ),
    );
  }

  Widget _aboutGampah(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 24, 0, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleAbout(),
          SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                ),
                CardAbout(
                  picture: "assets/home_about1.png",
                  title: "Apa itu\nGampah",
                  onTap: () {
                    Navigator.pushNamed(context, AboutPage.routeName);
                  },
                ),
                CardAbout(
                  picture: "assets/home_about2.png",
                  title: "Cara\nPakai Gampah",
                  onTap: () {
                    Navigator.pushNamed(context, TutorialPage.routeName);
                  },
                ),
                CardAbout(
                    picture: "assets/home_about3.png",
                    title: "Sudah\nMengertikan\nCara Pakai\nGampah?"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bottomNavigation() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
            if (currentIndex == 1) {
              Navigator.pushNamed(context, TransactionPage.routeName);
              currentIndex = 0;
            }
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: darkGreenColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "home",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.description,
                ),
                label: "Transaction")
          ],
        ),
      ),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, RegisterTransaction.routeName);
      },
      child: Icon(Icons.center_focus_strong),
      backgroundColor: softBlueColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.getUser;
    return Scaffold(
      extendBody: true,
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _bottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  _clipPath(context),
                  _header(
                      "${user!.name[0].toUpperCase()}${user.name.substring(1)}"),
                  _titleActivity()
                ],
              ),
              _cardActivity(context),
              _aboutGampah(context)
            ],
          ),
        ),
      ),
    );
  }
}
