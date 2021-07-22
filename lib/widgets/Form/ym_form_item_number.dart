import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 表单-计数行
class YmFormItemNumber extends StatelessWidget {
  String label;
  int number;
  Color textColor;
  Color labelTextColor;
  double fontSize;
  final Size size;
  Function()? onMinusClick;
  Function()? onPlusClick;

  YmFormItemNumber(
    this.number, {
    this.label = "",
    this.size = const Size(120, 40),
    this.fontSize = 14,
    this.textColor = const Color(0xff666666),
    this.labelTextColor = const Color(0xff333333),
    this.onMinusClick,
    this.onPlusClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        border: Border(
          bottom: BorderSide(color: Color(0xFFEFEFEF), width: 0.5),
        ),
      ),
      width: this.size.width,
      height: this.size.height,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: EdgeInsets.only(top: 0, left: 16, right: 0, bottom: 0),
          child: Row(
            children: [
              Text(
                this.label,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: this.labelTextColor,
                  fontSize: this.fontSize,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0, left: 0, right: 16, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (this.number > 1)
                  ? IconButton(
                      icon: Icon(Icons.remove_circle_outline_rounded),
                      color: Color(0xff999999),
                      onPressed: () {
                        if (onMinusClick != null) {
                          onMinusClick!();
                        }
                      },
                      iconSize: 24,
                    )
                  : IconButton(
                      icon: Icon(Icons.remove_circle_outline_rounded),
                      color: Color(0xffEFEFEF),
                      onPressed: () {},
                      iconSize: 24,
                    ),
              Text(
                this.number.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: this.textColor,
                  fontSize: this.fontSize,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline_rounded),
                color: Color(0xff999999),
                onPressed: () {
                  if (onPlusClick != null) {
                    onPlusClick!();
                  }
                },
                iconSize: 24,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
