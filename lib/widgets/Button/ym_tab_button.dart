import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///普通样式的Tab Button
class YmTabButton extends StatelessWidget {

  final String text;
  final Color textColor;
  final double fontSize;
  final bool isSelected;
  final Function() onClick;
  final Size size;
  final Color selectedBackgroundColor;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final Color borderColor;

  YmTabButton(this.text,this.textColor,this.fontSize,this.isSelected,this.onClick,
      {
        this.size = const Size(100, 50),
        this.backgroundColor = const Color(0xff818DFF),
        this.selectedBackgroundColor = const Color(0xff3446F2),
        this.borderColor = const Color(0x00ffffff),
        this.borderRadius = const BorderRadius.horizontal(left:Radius.circular(2),right: Radius.circular(2)),
      }
  );

  @override
  Widget build(BuildContext context) {
    return buildTabButton();
  }

  Widget buildTabButton() {

    BoxDecoration boxDecorationTabNormal = BoxDecoration(
        color: backgroundColor,
        border: Border.all(width: 0.5, style: BorderStyle.solid,color:borderColor),
        borderRadius: borderRadius
    );

    BoxDecoration boxDecorationTabSelected = BoxDecoration(
        color: selectedBackgroundColor,
        border: Border.all(width: 0.5, style: BorderStyle.solid,color:borderColor),
        borderRadius: borderRadius
    );

    return GestureDetector(
        child: new Container(
            width: size.width,
            height: size.height,
            margin: EdgeInsets.only(left:10),
            decoration: this.isSelected ? boxDecorationTabSelected : boxDecorationTabNormal,
            child:Row(
                mainAxisAlignment:MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top:0,left: 5,right: 5,bottom: 0),
                      child: Text(
                        text,
                        textAlign:TextAlign.center,
                        style: TextStyle(
                          color: this.isSelected?Color(0xffffffff):textColor ,
                          fontSize: this.fontSize,
                        ),
                      )
                  ),
                ]
            )
        ),
        onTap:(){
          onClick();
          //this._updateList(_selectedTypeTabIndex);
        }
    );
  }
}