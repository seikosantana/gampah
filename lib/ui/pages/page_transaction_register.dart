import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gampah_app/helper_functions.dart/geolocation.dart';
import 'package:gampah_app/models/model_user.dart';
import 'package:gampah_app/provider/auth_provider.dart';
import 'package:gampah_app/provider/transactions_provider.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/error/error.dart';
import 'package:gampah_app/ui/error/error_gps.dart';
import 'package:gampah_app/ui/error/success_transaction.dart';
import 'package:gampah_app/ui/widgets/btn_loading.dart';
import 'package:gampah_app/ui/widgets/form_controls/gampah_text_field.dart';
import 'package:gampah_app/ui/widgets/widget_toolbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterTransaction extends StatefulWidget {
  const RegisterTransaction({Key? key}) : super(key: key);
  static const routeName = "/resgister_transaction";

  @override
  State<RegisterTransaction> createState() => _RegisterTransactionState();
}

class _RegisterTransactionState extends State<RegisterTransaction> {
  TextEditingController addressController = TextEditingController(text: '');

  File? image;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

  bool isLoading = false;

  Widget _toolbar() {
    return CustomToolbar(title: "Buat Transaksi");
  }

  Widget _textField(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GampahTextField(
            labelText: "Detail Alamat (Opsional)",
            controller: addressController,
          ),
          SizedBox(
            height: 16,
          ),
          Text("Ambil Foto Sampah"),
          InkWell(
            onTap: () => pickImage(),
            child: image != null
                ? Container(
                    margin: EdgeInsets.only(bottom: 24),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: Image.file(
                        image!,
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    margin: EdgeInsets.only(top: 16, bottom: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: softWhiteColor,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.camera_alt,
                        color: softGreyColor,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _customButton(BuildContext context, Function() handle) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: handle,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(darkGreenColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        child: isLoading
            ? CircularProgressIndicator(
                color: whiteColor,
              )
            : Center(
                child: Text(
                  "Laporkan",
                  style: appTextTheme.button,
                ),
              ),
      ),
    );
  }

  Widget _alertWarning() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: yellowColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: yellowColor, width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: darkGreyColor,
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            "Lokasi anda sudah direkam",
            style: appTextTheme.bodyText1!.copyWith(color: darkGreyColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.getUser;
    handleTransaction() async {
      setState(() {
        isLoading = true;
      });
      if (image != null) {
        Position? currentPosition =
            await determinePosition(locationNotEnabledCallback: () {
          Navigator.pushNamed(context, ErrorGpsPage.routeName);
        }, permissionDeniedCallback: () {
          Navigator.pushNamed(context, ErrorPage.routeName);
        });
        bool result = await transactionProvider.addTransaction(
            user!.id,
            addressController.text,
            "success",
            currentPosition!.latitude,
            currentPosition.longitude,
            image!.path);

        print(currentPosition);
        if (result) {
          transactionProvider.fetchAllData();
          return Navigator.pushReplacementNamed(
              context, TransactionSuccess.routeName);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: redColor,
            content: Text(
              'Transaksi Gagal dibuat!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _toolbar(),
              _alertWarning(),
              _textField(context),
              _customButton(context, handleTransaction),
            ],
          ),
        ),
      ),
    );
  }
}
