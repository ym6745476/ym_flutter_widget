import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:ym_flutter_widget/widgets/TextField/ym_text_field.dart';

/// 表单-输入控件
class YmFormItemInput extends StatelessWidget {
  String label;
  String text;
  String hintText;
  Color textColor;
  Color labelTextColor;
  double fontSize;
  final Size size;
  FocusNode? focusNode;
  final bool required;
  final Function(String text) onTextChanged;
  final List<TextInputFormatter> inputFormatters;

  YmFormItemInput(
    this.text, {
    this.label = "",
    required this.onTextChanged,
    this.hintText = "请输入",
    this.size = const Size(120, 44),
    this.fontSize = 14,
    this.textColor = const Color(0xff666666),
    this.labelTextColor = const Color(0xff333333),
    this.inputFormatters = const [],
    this.required = false,
    this.focusNode,
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
          required?Text(
            "*",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFFF0000),
            ),
          ):Container(),
          Expanded(
            child: YmTextField(
              inputFormatters,
              this.text,
              onTextChanged,
              fontSize: 14,
              textAlign: TextAlign.right,
              hintText: this.hintText,
              focusNode: this.focusNode,
              outlineInputBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0), borderSide: BorderSide(color: Color(0x00606FFF))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0), borderSide: BorderSide(color: Color(0x003446F2))),
            ),
          ),
        ],
      ),
    );
  }
}
