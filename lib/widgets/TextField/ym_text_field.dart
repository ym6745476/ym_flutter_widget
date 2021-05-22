import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///无边框输入框
class YmTextField extends StatelessWidget {

  final List<TextInputFormatter> inputFormatters;
  final Function(String text) onTextChanged;
  final String text;
  final double fontSize;
  late OutlineInputBorder outlineInputBorder;
  late OutlineInputBorder focusedBorder;
  final TextEditingController controller = TextEditingController();

  ///[FilteringTextInputFormatter.digitsOnly,FilteringTextInputFormatter.allow(RegExp("[0-9.]")]
  YmTextField(this.inputFormatters,this.text,this.onTextChanged,
      {
        this.fontSize = 30,
        this.outlineInputBorder = const OutlineInputBorder(),
        this.focusedBorder = const OutlineInputBorder()
      }
  );

  @override
  Widget build(BuildContext context) {
    return buildTextField();
  }

  Widget buildTextField() {

    //controller初始化值
    this.controller.text = text;

    return Theme(
      data: new ThemeData(primaryColor:Color(0x003446F2), hintColor: Colors.black45),
      child: TextField(
        controller: controller,
        autofocus: true,
        textAlign: TextAlign.left,//文本对齐方式
        maxLines: 1,//最大行数
        style: TextStyle(fontSize: fontSize, color: Colors.black87,fontWeight:FontWeight.w500),//输入文本的样式
        inputFormatters: this.inputFormatters,   //允许的输入格式
        onChanged: (text) {
          onTextChanged(text);
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            border: outlineInputBorder,
            focusedBorder: focusedBorder,
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
      selectionIndex ++;
    } else if (value != "") {
      if(value.lastIndexOf(".")!=value.indexOf(".")){
        //2个.做截断
        value = value.substring(0,value.lastIndexOf("."));
        selectionIndex = value.length;
      }
      if(value.indexOf(".")!=-1){
        if(value.substring(value.lastIndexOf(".")).length > 2){
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