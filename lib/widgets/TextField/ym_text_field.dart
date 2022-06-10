import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 输入框
class YmTextField extends StatelessWidget {
  final List<TextInputFormatter> inputFormatters;
  final Function(String text) onTextChanged;
  final String text;
  final double fontSize;
  final double height;
  final String hintText;
  final Color textColor;
  final Color hintTextColor;
  final TextAlign textAlign;
  final EdgeInsets contentPadding;
  final FocusNode? focusNode;
  final int maxLines;
  late OutlineInputBorder outlineInputBorder;
  late OutlineInputBorder focusedBorder;
  late TextEditingController controller;

  ///[FilteringTextInputFormatter.digitsOnly,FilteringTextInputFormatter.allow(RegExp("[0-9.]")]
  YmTextField(this.inputFormatters, this.text, this.onTextChanged,
      {
        this.fontSize = 30,
        this.height = 30,
        this.hintText = "",
        this.textColor = const Color(0xff666666),
        this.hintTextColor = const Color(0xff999999),
        this.maxLines = 1,
        this.focusNode,
        this.textAlign = TextAlign.left,
        this.outlineInputBorder = const OutlineInputBorder(),
        this.focusedBorder = const OutlineInputBorder(),
        this.contentPadding = const EdgeInsets.symmetric(horizontal: 5, vertical: 2)
      }
  );


  @override
  Widget build(BuildContext context) {
    return buildTextField();
  }

  Widget buildTextField() {
    //controller初始化值
    this.controller = TextEditingController.fromValue(
      TextEditingValue(
          text: text,
          selection: TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: text.length))),
    );

    return Theme(
      data: new ThemeData(primaryColor: Color(0xFF3446F2), hintColor: Colors.black45),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: height,
        ),
        child: TextField(
          controller: controller,
          autofocus: false,
          focusNode: this.focusNode,
          textAlign: this.textAlign, //文本对齐方式
          maxLines: maxLines, //最大行数
          style: TextStyle(fontSize: fontSize, color: textColor, fontWeight: FontWeight.w500), //输入文本的样式
          inputFormatters: this.inputFormatters, //允许的输入格式
          onChanged: (text) {
            onTextChanged(text);
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: fontSize, color: hintTextColor),
            contentPadding: this.contentPadding,
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            focusedBorder: focusedBorder,
          ),
        ),
      ),
    );
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.01;
  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;

    if (value == "." || value == "。") {
      value = "0.";
      selectionIndex++;
    } else if (value != "") {
      if (value.lastIndexOf(".") != value.indexOf(".")) {
        //2个.做截断
        value = value.substring(0, value.lastIndexOf("."));
        selectionIndex = value.length;
      }
      if (value.indexOf(".") != -1) {
        if (value.substring(value.lastIndexOf(".")).length > 2) {
          value = double.parse(value).toStringAsFixed(2);
          selectionIndex = value.length;
        }
      }
    }
    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
