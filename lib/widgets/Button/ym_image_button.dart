import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///可以更换图标的单选按钮
class YmImageButton extends StatelessWidget {

  String text;
  Color textColor;
  double fontSize;
  String img;
  final Function() onClick;
  final Size size;
  final Color backgroundColor;

  YmImageButton(this.img,this.onClick,
      {
        this.text = "",
        this.size = const Size(20, 20),
        this.fontSize = 14,
        this.textColor = const Color(0xff333333),
        this.backgroundColor = const Color(0xffffffff),
      }
  );

  @override
  Widget build(BuildContext context) {
    return buildCheckButton();
  }

  Widget buildCheckButton() {

    return GestureDetector(
        child: new Container(
            decoration: BoxDecoration(color: backgroundColor),
            child:Row(
                mainAxisAlignment:MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    img,
                    fit:BoxFit.fitWidth,
                    width:this.size.width,
                    height:this.size.height,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top:0,left: 8,right: 5,bottom: 0),
                      child: Text(
                        text,
                        textAlign:TextAlign.center,
                        style: TextStyle(
                          color: textColor ,
                          fontSize: this.fontSize,
                        ),
                      )
                  ),
                ]
            )
        ),
        onTap:(){
          onClick();
        }
    );
  }
}