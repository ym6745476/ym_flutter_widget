import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///单选按钮组合文字
class YmRadioButton extends StatelessWidget {

  String text;
  Color textColor;
  double fontSize;
  int value;
  int groupValue;
  Color color;
  final Function(dynamic value) onChanged;
  final Size size;

  YmRadioButton(
      {
        required this.value,
        required this.groupValue,
        required this.onChanged,
        this.text = "",
        this.size = const Size(120, 40),
        this.fontSize = 14,
        this.textColor = const Color(0xff333333),
        this.color = Colors.indigo,
      }
  );

  @override
  Widget build(BuildContext context) {
    return buildCheckButton();
  }

  Widget buildCheckButton() {

    return Container(
        width: size.width,
        height: size.height,
        child:Row(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio(value:this.value,
                groupValue: this.groupValue,
                onChanged: (value){
                  this.onChanged(value);
                },
                activeColor:this.color,
                toggleable: true,
              ),
              Padding(
                  padding: EdgeInsets.only(top:0,left: 5,right: 5,bottom: 0),
                  child: Text(
                    text,
                    textAlign:TextAlign.left,
                    style: TextStyle(
                      color: textColor ,
                      fontSize: this.fontSize,
                    ),
                  )
              ),
            ]
        )
    );
  }
}