import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

///普通样式的Button
class YmTextButton extends StatelessWidget {

  final String text;
  final Color textColor;
  final Function() onClick;
  final double fontSize;
  final FontWeight fontWeight;
  final Size size;
  final Color foregroundColor;
  final Color backgroundColor;
  final bool isOutlined;
  final bool isGradient;
  final Color borderColor;
  final LinearGradient gradient;

  //BeveledRectangleBorder 带斜角的长方形边框
  //CircleBorder 圆形边框
  //RoundedRectangleBorder 圆角矩形  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
  //StadiumBorder 两端是半圆的边框
  final OutlinedBorder outlinedBorder;

  YmTextButton(this.text,this.textColor,this.onClick,{
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.size = const Size(120, 42),
    this.isOutlined = false,
    this.isGradient = false,
    this.borderColor = const Color(0xFF3446F2),
    this.foregroundColor = const Color(0xFF606FFF),
    this.backgroundColor = const Color(0xFF3446F2),
    this.outlinedBorder = const StadiumBorder(),
    this.gradient = const LinearGradient( colors: [const Color(0xFF606FFF),const Color(0xFF3446F2)]),
  });

  @override
  Widget build(BuildContext context) {
    if(isGradient){
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
    }else{
      return buildTextButton();
    }
  }

  Widget buildTextButton() {
    if (isOutlined) {
      return OutlinedButton(
        style: ButtonStyle(
          padding:MaterialStateProperty.all(EdgeInsets.zero),
          side:MaterialStateProperty.all(BorderSide(color:borderColor)),
          //设置按钮的大小
          minimumSize: MaterialStateProperty.all(size),
          //外边框装饰
          shape: MaterialStateProperty.all(outlinedBorder),
        ),
        child: new Text(text,
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
    } else {
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
              if (states.contains(MaterialState.focused) &&
                  !states.contains(MaterialState.pressed)) {
                //获取焦点时的颜色
                return foregroundColor;
              } else if (states.contains(MaterialState.pressed)) {
                //按下时的颜色
                return foregroundColor;
              }
              //默认状态使用的颜色
              return backgroundColor;
            },
          ),
          //背景颜色
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            //设置按下时的背景颜色
            if (states.contains(MaterialState.pressed)) {
              return foregroundColor;
            }
            //默认使用背景颜色
            return backgroundColor;
          }),
          //设置按钮的大小
          minimumSize: MaterialStateProperty.all(size),
          //外边框装饰
          shape: MaterialStateProperty.all(outlinedBorder),

        ),
        child: new Text(text,
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
}