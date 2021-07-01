import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_text_button.dart';
import 'package:ym_flutter_widget/widgets/Cascader/ym_picker.dart';

/// 级联选择器（多级）
class YmCascader extends StatefulWidget {

  //数据
  late List<List<Map>> data;

  //默认Value
  late List<String> value;

  final double width;
  final double height;
  final Function onChanged;
  final Function onOkClick;
  final Function onCancelClick;
  final Color backgroundColor;
  final double itemHeight;

  YmCascader(
      this.data,
      this.value,
      {
        Key? key,
        required this.onChanged,
        required this.onOkClick,
        required this.onCancelClick,
        this.itemHeight = 36,
        this.backgroundColor = const Color(0xffffffff),
        this.height = 150.0,
        this.width = 150.0
      }
  ): super(key: key);

  @override
  _YmCascaderState createState() => _YmCascaderState();

}

class _YmCascaderState extends State<YmCascader> {

  @override
  void initState() {
    super.initState();
  }

  Widget _getPickerWidget(int position){
    double pickerItemWidth = (MediaQuery.of(context).size.width)/widget.data.length;
    return YmPicker(
      widget.data.elementAt(position),
      widget.value[position],
      width: pickerItemWidth,
      itemHeight: 40,
      height: 180,
      onChanged: (index,val) {
        print("Picker onChanged  position=" + position.toString() + ",index=" + index.toString() + ",val=" + val);
        widget.onChanged(position,index,val);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:220,
      decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(
            height: 1,
            color: Color(0xFFEFEFEF),
            thickness: 1,
          ),
          Container(
            height:39,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YmTextButton("取消", textColor:Color(0xFF666666), onClick: (){
                    widget.onCancelClick();
                  },size: Size(80,40),backgroundColor: Colors.transparent,pressedBackgroundColor:Color(0xFFEFEFEF) ,),

                  YmTextButton("确定", textColor:Color(0xFF3446F2), onClick:(){
                    widget.onOkClick();
                  },size:Size(80,40),backgroundColor: Colors.transparent,pressedBackgroundColor:Color(0xFFEFEFEF)),
                ]
            ),
          ),

          Row(
            children:List.generate(widget.data.length, (index) {
              return _getPickerWidget(index);
            }),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}