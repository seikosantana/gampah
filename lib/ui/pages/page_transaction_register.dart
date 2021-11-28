import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';
import 'package:gampah_app/ui/widgets/form_controls/gampah_text_field.dart';
import 'package:gampah_app/ui/widgets/widget_toolbar.dart';
import 'package:image_picker/image_picker.dart';

class RegisterTransaction extends StatefulWidget {
  const RegisterTransaction({Key? key}) : super(key: key);
  static const routeName = "/resgister_transaction";

  @override
  State<RegisterTransaction> createState() => _RegisterTransactionState();
}

class _RegisterTransactionState extends State<RegisterTransaction> {
  File? image;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

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
                      color: Color(0xEFEFEFFF),
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

  Widget _customButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(darkGreenColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        child: Center(
          child: Text(
            "Laporkan",
            style: myTexTheme.button,
          ),
        ),
      ),
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
            children: [_toolbar(), _textField(context), _customButton()],
          ),
        ),
      ),
    );
  }
}
