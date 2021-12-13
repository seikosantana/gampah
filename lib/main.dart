import 'package:flutter/material.dart';
import 'package:gampah_app/models/model_transactions.dart';
import 'package:gampah_app/provider/auth_provider.dart';
import 'package:gampah_app/provider/transactions_provider.dart';
import 'package:gampah_app/services/transactions_service.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/error/error.dart';
import 'package:gampah_app/ui/error/error_gps.dart';
import 'package:gampah_app/ui/error/success_register.dart';
import 'package:gampah_app/ui/error/success_transaction.dart';
import 'package:gampah_app/ui/pages/page_about.dart';
import 'package:gampah_app/ui/pages/page_get_started.dart';
import 'package:gampah_app/ui/pages/page_home.dart';
import 'package:gampah_app/ui/pages/page_login.dart';
import 'package:gampah_app/ui/pages/page_profile.dart';
import 'package:gampah_app/ui/pages/page_register.dart';
import 'package:gampah_app/ui/pages/page_splash.dart';
import 'package:gampah_app/ui/pages/page_test_widget.dart';
import 'package:gampah_app/ui/pages/page_transaction.dart';
import 'package:gampah_app/ui/pages/page_transaction_detail.dart';
import 'package:gampah_app/ui/pages/page_transaction_register.dart';
import 'package:gampah_app/ui/pages/page_tutorial.dart';
import 'package:provider/provider.dart';

void main() => runApp(TestPage());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              TransactionProvider(transactionsService: TransactionsService()),
        ),
      ],
      child: MaterialApp(
        title: "Gampah",
        theme: ThemeData(textTheme: appTextTheme),
        home: GetStartedPage(),
        initialRoute: SplashPage.routeName,
        routes: {
          SplashPage.routeName: (context) => SplashPage(),
          GetStartedPage.routeName: (context) => GetStartedPage(),
          HomePage.routeName: (context) => HomePage(),
          LoginPage.routeName: (context) => LoginPage(),
          RegisterPage.routeName: (context) => RegisterPage(),
          RegisterTransaction.routeName: (context) => RegisterTransaction(),
          TransactionPage.routeName: (context) => TransactionPage(),
          TransactionDetailPage.routeName: (context) => TransactionDetailPage(
                transactionList: ModalRoute.of(context)?.settings.arguments
                    as TransactionList,
              ),
          AboutPage.routeName: (context) => AboutPage(),
          TutorialPage.routeName: (context) => TutorialPage(),
          ErrorPage.routeName: (context) => ErrorPage(),
          ErrorGpsPage.routeName: (context) => ErrorGpsPage(),
          RegisterSuccess.routeName: (context) => RegisterSuccess(),
          TransactionSuccess.routeName: (context) => TransactionSuccess(),
          PageProfile.routeName: (context) => PageProfile(),
        },
      ),
    );
  }
}
