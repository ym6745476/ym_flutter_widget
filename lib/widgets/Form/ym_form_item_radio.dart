import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_check_button.dart';

/// 表单-单选按钮行
class YmFormItemRadio extends StatefulWidget {
  List<String> labels;
  List<int> values;
  int value;
  String label;
  Color textColor;
  Color labelTextColor;
  double fontSize;
  final Size size;
  Function(bool checked, dynamic value)? onChanged;

  YmFormItemRadio(this.labels,
      this.values,
      this.value, {
        this.label = "",
        this.size = const Size(120, 40),
        this.fontSize = 14,
        this.textColor = const Color(0xff666666),
        this.labelTextColor = const Color(0xff333333),
        this.onChanged,
      });

  @override
  _YmFormItemState createState() => _YmFormItemState();
}

class _YmFormItemState extends State<YmFormItemRadio>{

  int currentValue = 0;

  @override
  void initState() {
    super.initState();
    this.currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        border: Border(
          bottom: BorderSide(color: Color(0xFFEFEFEF), width: 0.5),
        ),
      ),
      width: widget.size.width,
      height: widget.size.height,
      padding: EdgeInsets.only(top: 0, left: 16, right: 0, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: widget.labelTextColor,
              fontSize: widget.fontSize,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                widget.labels.length,
                (index) => YmCheckButton(
                  value: widget.values[index],
                  checked: currentValue ==  widget.values[index],
                  onChanged: (bool checked, dynamic value) {
                    if (checked) {
                      setState(() {
                        currentValue = value;
                      });
                    }
                    if (widget.onChanged != null) {
                      widget.onChanged!(checked, value);
                    }
                  },
                  text: widget.labels[index],
                  image: "assets/images/ic_radio.png",
                  checkedImage: "assets/images/ic_radio_checked.png",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
