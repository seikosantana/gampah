import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GampahTextField extends StatefulWidget {
  String? labelText;
  Icon? preIcon;
  Widget? postAction;
  bool? maskText;

  GampahTextField(
      {this.labelText, this.preIcon, this.postAction, this.maskText, Key? key})
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
      padding: EdgeInsets.all(20),
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
                if (widget.preIcon != null)
                  Container(
                    padding: EdgeInsets.only(right: 14),
                    child: widget.preIcon,
                  ),
                Expanded(
                  child: TextFormField(
                    obscureText: widget.maskText ?? false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
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
              color: Color(0xEFEFEFFF),
            ),
          )
        ],
      ),
    );
  }
}
