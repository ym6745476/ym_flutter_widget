import 'package:flutter/material.dart';

/// 自定义空页面
class YmEmpty extends StatelessWidget {
  // 文本名称
  String message;
  String image;
  final Color textColor;

  //构造方法
  YmEmpty(
      this.message,
      this.image,{
      this.textColor = const Color(0xFF606FFF),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: ShapeDecoration(
          color: Color(0x00FFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero),
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Image.asset(image, height: 100, fit: BoxFit.fitWidth),
          ),
          Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                ),
              ))
        ]));
  }
}
