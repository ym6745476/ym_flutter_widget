import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Tab样式的按钮
class YmTabButton extends StatelessWidget {

  final String text;
  final Color textColor;
  final Color selectedTextColor;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isSelected;
  final Function() onClick;
  final Size size;
  final Color selectedBackgroundColor;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final Color borderColor;
  final Color selectedBorderColor;

  YmTabButton(this.text,
      {
        required this.onClick,
        this.textColor = const Color(0xFF666666),
        this.selectedTextColor = const Color(0xFFFFFFFF),
        this.fontSize = 14,
        this.fontWeight = FontWeight.normal,
        this.isSelected = false,
        this.size = const Size(80, 40),
        this.backgroundColor = const Color(0xFF818DFF),
        this.selectedBackgroundColor = const Color(0xFF3446F2),
        this.borderColor = Colors.transparent,
        this.selectedBorderColor = Colors.transparent,
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
        border: Border.all(width: 0.5, style: BorderStyle.solid,color:selectedBorderColor),
        borderRadius: borderRadius
    );

    return GestureDetector(
        child:  Container(
            width: size.width,
            height: size.height,
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
                          color: this.isSelected?selectedTextColor:textColor ,
                          fontSize: this.fontSize,
                          fontWeight: this.fontWeight,
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