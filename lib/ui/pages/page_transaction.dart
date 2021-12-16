import 'package:flutter/material.dart';
import 'package:gampah_app/models/model_user.dart';
import 'package:gampah_app/provider/auth_provider.dart';
import 'package:gampah_app/provider/transactions_provider.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/widgets/widget_card_item_transaction.dart';
import 'package:gampah_app/ui/widgets/widget_toolbar.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);
  static const routeName = "/transaction";

  Widget _toolbar() {
    return CustomToolbar(title: "Transaksi");
  }

  Widget _textHeader() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Text(
        "Transaksimu\nmenyelamatkan bumi\ndari sampah.",
        style: appTextTheme.headline6!.copyWith(color: softGreenColor),
      ),
    );
  }

  Color _colorOfStatus(String status) {
    switch (status) {
      case 'PENDING':
        return yellowColor;
      case 'DITINJAU':
        return softGreyColor;
      case 'DIJEMPUT':
        return softGreenColor;
      default:
        return yellowColor;
    }
  }

  Widget _cardTransaction(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.getUser;
    return Column(
      children: [
        Consumer<TransactionProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: darkGreenColor,
                ),
              );
            } else if (state.state == ResultState.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: state.transactions.length,
                itemBuilder: (context, index) {
                  var transaction = state.transactions[index];
                  return CardTransaction(
                    date: transaction.created_at,
                    name: user!.name,
                    status: transaction.status,
                    color: _colorOfStatus(transaction.status),
                    address: transaction.address_detail,
                    argument: transaction,
                  );
                },
              );
            } else if (state.state == ResultState.nodata) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.error) {
              return Center(child: Text(state.message));
            } else {
              return Center(
                child: Text(""),
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_toolbar(), _textHeader(), _cardTransaction(context)],
        ),
      ),
    ));
  }
}
