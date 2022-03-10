import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 表单-标题行
class YmFormItemTitle extends StatelessWidget {
  String text;
  Color textColor;
  Color backgroundColor;
  double fontSize;
  final Size size;
  final String iconLeft;

  YmFormItemTitle(this.text, {
    this.size = const Size(120, 40),
    this.iconLeft = "",
    this.fontSize = 14,
    this.textColor = const Color(0xff666666),
    this.backgroundColor = const Color(0xffffffff),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: this.size.width,
        height: this.size.height,
        color: this.backgroundColor,
        padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            this.iconLeft.isNotEmpty
                ? Padding(
              padding: EdgeInsets.only(top: 0, left: 0, right: 10, bottom: 0),
              child: Image.asset(
                this.iconLeft,
                fit: BoxFit.fitHeight,
                height: this.size.height * 0.6,
              )
              ,) : Container(),

            Text(
              this.text,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: this.fontSize,
                color: this.textColor,
              ),
            ),
          ],
        )

    );
  }
}
