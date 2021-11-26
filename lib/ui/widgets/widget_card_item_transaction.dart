import 'package:flutter/material.dart';
import 'package:gampah_app/style/color.dart';
import 'package:gampah_app/style/text_theme.dart';

class CardTransaction extends StatelessWidget {
  final String date;
  final String name;
  final String status;
  final Color color;
  final String address;
  final Function()? onTap;
  const CardTransaction({
    Key? key,
    required this.date,
    required this.name,
    required this.status,
    required this.color,
    required this.address,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 2),
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: myTexTheme.caption!.copyWith(color: softGreyColor),
                ),
                Divider(
                  color: softGreyColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: myTexTheme.bodyText2!
                            .copyWith(color: darkGreyColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          status,
                          style:
                              myTexTheme.caption!.copyWith(color: whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: Text(
                    address,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
