import 'package:flutter/material.dart';

/// 自定义空页面
class YmEmpty extends StatelessWidget {
  // 文本名称
  final String message;
  final String image;

  //构造方法
  YmEmpty(this.message, this.image);

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
                style: const TextStyle(
                  color: Color(0xFF606FFF),
                  fontSize: 14,
                ),
              ))
        ]));
  }
}
