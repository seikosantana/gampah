import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gampah_app/style/color.dart';

class GampahTextField extends StatefulWidget {
  String? labelText;
  Widget? prefix;
  Widget? postAction;
  bool? maskText;
  bool? isEnable;
  String? hintText;
  TextEditingController? controller;
  GampahTextField(
      {this.labelText,
      this.prefix,
      this.postAction,
      this.maskText,
      this.isEnable,
      this.hintText,
      this.controller,
      Key? key})
      : super(key: key);

  @override
  _GampahTextFieldState createState() {
    return _GampahTextFieldState();
  }
}

class _GampahTextFieldState extends State<GampahTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          if (widget.labelText != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Text(widget.labelText!)],
            ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              children: [
                if (widget.prefix != null)
                  Container(
                    padding: EdgeInsets.only(right: 14),
                    child: widget.prefix,
                  ),
                Expanded(
                  child: TextFormField(
                    obscureText: widget.maskText ?? false,
                    enabled: widget.isEnable,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hintText,
                    ),
                    controller: widget.controller,
                  ),
                ),
                if (widget.postAction != null)
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    child: widget.postAction,
                  )
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: softWhiteColor,
            ),
          )
        ],
      ),
    );
  }
}
