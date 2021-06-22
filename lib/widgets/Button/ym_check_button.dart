import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///可以更换图标的单选按钮
class YmCheckButton extends StatelessWidget {

  String text;
  Color textColor;
  double fontSize;
  int value;
  bool checked;
  final Function(bool checked,dynamic value) onChanged;
  final Size size;
  final String image;
  final String checkedImage;

  YmCheckButton(
      {
        required this.value,
        required this.onChanged,
        this.checked = false,
        this.text = "",
        this.size = const Size(80, 40),
        this.fontSize = 14,
        this.textColor = const Color(0xff333333),
        this.image = "assets/images/ic_box.png",
        this.checkedImage = "assets/images/ic_box_checked.png",

      }
  );

  @override
  Widget build(BuildContext context) {
    return buildCheckButton();
  }

  Widget buildCheckButton() {

    return GestureDetector(
        child: Container(
            width: size.width,
            height: size.height,
            child:Row(
                mainAxisAlignment:MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    this.checked?this.checkedImage:this.image,
                    fit:BoxFit.fitWidth,
                    width:22,
                    height:22,
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
          this.checked = !this.checked;
          onChanged(this.checked,this.value);
        }
    );
  }
}