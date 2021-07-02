import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 表单-标题行
class YmFormItemTitle extends StatelessWidget {

  String text;
  Color textColor;
  double fontSize;
  final Size size;

  YmFormItemTitle(
      this.text,
      {
        this.size = const Size(120, 40),
        this.fontSize = 14,
        this.textColor = const Color(0xff666666),
      }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width:this.size.width,
      height:this.size.height,
      color: Color(0xFFEFEFEF),
      padding: EdgeInsets.only(top:10,left: 16,right: 16,bottom: 10),
      child: Text(
        this.text,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: this.fontSize,
          color:this.textColor,
        ),
      ),
    );

  }

}