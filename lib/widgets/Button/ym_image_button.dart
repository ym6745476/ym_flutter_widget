import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///普通样式的Button
class YmImageButton extends StatelessWidget {

  final String text;
  final Color textColor;
  final Function() onClick;
  final double fontSize;
  final FontWeight fontWeight;
  final Size size;
  final Color pressedBackgroundColor;
  final Color backgroundColor;
  final bool isOutlined;
  final Color borderColor;
  final String iconLeft;
  final String iconRight;

  //BeveledRectangleBorder 带斜角的长方形边框
  //CircleBorder 圆形边框
  //RoundedRectangleBorder 圆角矩形  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
  //StadiumBorder 两端是半圆的边框
  final OutlinedBorder outlinedBorder;

  YmImageButton(this.text,this.onClick,{
    this.iconLeft = "",
    this.iconRight = "",
    this.textColor = const Color(0xFFFFFFFF),
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.size = const Size(160, 42),
    this.isOutlined = false,
    this.borderColor = const Color(0xFF3446F2),
    this.pressedBackgroundColor = const Color(0xFF606FFF),
    this.backgroundColor = const Color(0xFF3446F2),
    this.outlinedBorder =  const RoundedRectangleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return buildTextButton();
  }

  Widget buildTextButton() {
    if (isOutlined) {
      return OutlinedButton(
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

          side:MaterialStateProperty.all(BorderSide(color:borderColor)),
          //设置按钮最小的大小
          //minimumSize: MaterialStateProperty.all(size),
          //外边框装饰
          shape: MaterialStateProperty.all(outlinedBorder),
        ),
        child: Container(
          width: this.size.width,
          height: this.size.height,
          padding:EdgeInsets.only(top:0,left: 10,right: 10,bottom: 0),
          child: Row(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  this.iconLeft.isNotEmpty?Image.asset(
                    this.iconLeft,
                    fit:BoxFit.fitHeight,
                    height:this.size.height * 0.6,
                  ):Container(),
                  Padding(
                    padding: EdgeInsets.only(top:0,left: 5,right: 5,bottom: 0),
                    child: Text(text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                      ),
                    ),
                  ),

                  this.iconRight.isNotEmpty?Image.asset(
                    iconRight,
                    fit:BoxFit.fitHeight,
                    height:this.size.height * 0.6,
                  ):Container(),
              ]
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

              if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
                //获取焦点和按下时的颜色
                return pressedBackgroundColor;
              }
              //默认状态使用的颜色
              return backgroundColor;
            },
          ),

          backgroundColor: MaterialStateProperty.resolveWith((states) {
            //设置按下时的背景颜色
            if (states.contains(MaterialState.focused) ||  states.contains(MaterialState.pressed)) {
              return pressedBackgroundColor;
            }else{
              return backgroundColor;
            }
          }),
          //设置按钮最小的大小
          //minimumSize: MaterialStateProperty.all(size),
          //外边框装饰
          shape: MaterialStateProperty.all(outlinedBorder),

        ),
        child:Container(
          width: this.size.width,
          height: this.size.height,
          padding:EdgeInsets.only(top:0,left: 10,right: 10,bottom: 0),
          child: Row(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                this.iconLeft.isNotEmpty?Image.asset(
                  this.iconLeft,
                  fit:BoxFit.fitHeight,
                  height:this.size.height * 0.6,
                ):Container(),
                Padding(
                  padding: EdgeInsets.only(top:0,left: 5,right: 5,bottom: 0),
                  child: Text(text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    ),
                  ),
                ),

                this.iconRight.isNotEmpty?Image.asset(
                  iconRight,
                  fit:BoxFit.fitHeight,
                  height:this.size.height * 0.6,
                ):Container(),
              ]
          ),
        ),

        onPressed: () {
          onClick();
        },
      );
    }
  }
}