import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/ui/widgets/form_controls/gampah_text_field.dart';
import 'package:gampah_app/ui/widgets/widget_toolbar.dart';
import 'package:gampah_app/ui/widgets/wiget_circular_image.dart';

class PageProfile extends StatefulWidget {
  @override
  PageProfileState createState() {
    return PageProfileState();
  }
}

class PageProfileState extends State<PageProfile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Expanded(
          child: Column(
            children: [
              CustomToolbar(
                title: "Profil",
              ),
              SizedBox(
                height: 48,
              ),
              CircularImage(
                image: AssetImage("assets/image_profile.png"),
              ),
              SizedBox(
                height: 24,
              ),
              Chip(
                label: Text(
                  "Pengguna",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: softGreenColor,
                padding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 16,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    GampahTextField(
                      labelText: "Nama kamu",
                      prefix: Icon(Icons.person_rounded),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    GampahTextField(
                      labelText: "Nomor HP",
                      prefix: Text("+62"),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    GampahTextField(
                      labelText: "Email kamu",
                      prefix: Icon(Icons.mail),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
