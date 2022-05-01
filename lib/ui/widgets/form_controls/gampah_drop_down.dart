// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';

class GampahDropDown<T> extends StatefulWidget {
  String? labelText;
  Widget? prefix;
  Widget? postAction;
  List<DropdownMenuItem<T>> items;
  void Function(T?)? onChanged;
  dynamic value;

  GampahDropDown(
      {this.labelText,
      this.prefix,
      this.postAction,
      required this.items,
      this.onChanged,
      this.value,
      Key? key})
      : super(key: key);

  @override
  _GampahDropDownState createState() {
    return _GampahDropDownState<T>();
  }
}

class _GampahDropDownState<T> extends State<GampahDropDown<T>> {
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
                  child: DropdownButtonFormField<T>(
                    items: widget.items,
                    value: widget.value,
                    onChanged: widget.onChanged,
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
              color: softWhiteColor,
            ),
          )
        ],
      ),
    );
  }
}
