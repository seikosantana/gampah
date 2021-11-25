import 'package:flutter/material.dart';

class GampahTextField extends StatefulWidget {
  const GampahTextField({Key? key}) : super(key: key);

  @override
  _GampahTextFieldState createState() {
    return _GampahTextFieldState();
  }
}

class _GampahTextFieldState extends State<GampahTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(),
    );
  }
}
