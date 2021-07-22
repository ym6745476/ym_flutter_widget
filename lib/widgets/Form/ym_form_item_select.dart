import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ym_flutter_widget/utils/ym_string_util.dart';
import 'package:ym_flutter_widget/widgets/TextField/ym_text_field.dart';

/// 表单-选择控件
class YmFormItemSelect extends StatelessWidget {
  String label;
  String text;
  String hintText;
  Color textColor;
  Color labelTextColor;
  double fontSize;
  final Size size;
  String? rightImage;
  final Function() onClick;

  YmFormItemSelect(
    this.text, {
    required this.onClick,
    this.hintText = "请选择",
    this.label = "",
    this.size = const Size(120, 44),
    this.fontSize = 14,
    this.textColor = const Color(0xff666666),
    this.labelTextColor = const Color(0xff333333),
    this.rightImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size.width,
      height: this.size.height,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        border: Border(
          bottom: BorderSide(color: Color(0xFFEFEFEF), width: 0.5),
        ),
      ),
      padding: EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            this.label,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: 14,
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      this.text != "" ? this.text : this.hintText,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: this.textColor,
                        fontSize: this.fontSize,
                      ),
                    ),
                    YmStringUtil.strNotEmpty(this.rightImage)
                        ? Padding(
                            padding: EdgeInsets.only(top: 0, left: 5, right: 0, bottom: 0),
                            child: Image.asset(
                              this.rightImage!,
                              fit: BoxFit.fitWidth,
                              width: 20,
                            ),
                          )
                        : Container(),
                  ]),
              onTap: onClick,
            ),
          ),
        ],
      ),
    );
  }
}
