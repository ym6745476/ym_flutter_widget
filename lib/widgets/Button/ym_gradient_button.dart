import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 背景是渐变色的Button
class YmGradientButton extends StatelessWidget {

  final String text;
  final Color textColor;
  final Function() onClick;
  final double fontSize;
  final FontWeight fontWeight;
  final Size size;
  final Color pressedBackgroundColor;
  final Color borderColor;
  final LinearGradient gradient;

  //BeveledRectangleBorder 带斜角的长方形边框
  //CircleBorder 圆形边框
  //RoundedRectangleBorder 圆角矩形  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
  //StadiumBorder 两端是半圆的边框
  final OutlinedBorder outlinedBorder;

  YmGradientButton(this.text,this.textColor,this.onClick,{
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.size = const Size(120, 42),
    this.borderColor = Colors.transparent,
    this.pressedBackgroundColor = const Color(0xFF606FFF),
    this.outlinedBorder = const StadiumBorder(),
    this.gradient = const LinearGradient( colors: [const Color(0xFF606FFF),const Color(0xFF3446F2)]),
  });

  @override
  Widget build(BuildContext context) {
      return Container(
        width: size.width,
        height: size.height,
        margin: EdgeInsets.all(0),
        decoration: BoxDecoration(
          gradient:gradient,
          border: Border.all(width: 0.5, style: BorderStyle.solid,color:borderColor),
          borderRadius:BorderRadius.horizontal(left:Radius.circular(size.height/2),right: Radius.circular(size.height/2)),
        ),
        child:buildTextButton(),
      );
  }

  Widget buildTextButton() {

      return ElevatedButton(
        style: ButtonStyle(
          padding:MaterialStateProperty.all(EdgeInsets.zero),
          shadowColor: MaterialStateProperty.resolveWith(
                (states) {
                  return Colors.transparent;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith(
                (states) {

              if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
                //获取焦点和按下时的颜色
                return pressedBackgroundColor;
              }
              //默认状态使用的颜色
              return Colors.transparent;
            },
          ),

          backgroundColor: MaterialStateProperty.resolveWith((states) {
            //设置按下时的背景颜色
            if (states.contains(MaterialState.focused) ||  states.contains(MaterialState.pressed)) {
              return pressedBackgroundColor;
            }else{
              return Colors.transparent;
            }
          }),

          //设置按钮的最小尺寸
          //minimumSize: MaterialStateProperty.all(size),
          //外边框装饰
          shape: MaterialStateProperty.all(outlinedBorder),

        ),
        child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
        onPressed: () {
          onClick();
        },
      );
    }
}