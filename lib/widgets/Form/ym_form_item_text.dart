import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

/// 表单-不可输入控件
class YmFormItemText extends StatelessWidget {
  String label;
  String text;
  Color textColor;
  Color labelTextColor;
  double fontSize;
  final Size size;
  final bool required;

  YmFormItemText(this.text, {
    this.label = "",
    this.size = const Size(120, 44),
    this.fontSize = 14,
    this.textColor = const Color(0xff666666),
    this.labelTextColor = const Color(0xff333333),
    this.required = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size.width,
      height: this.size.height,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        border: Border(
          bottom: BorderSide(color: Color(0xFFEFEFEF), width: 0.5),
        ),
      ),
      padding: EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            this.label,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: labelTextColor,
              fontSize: 14,
            ),
          ),
          required ? Text(
            "*",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFFF0000),
            ),
          ) : Container(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 0),
              child:Text(
                this.text,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
