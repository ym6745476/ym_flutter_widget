import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_text_button.dart';
import 'package:ym_flutter_widget/widgets/Cascader/ym_picker.dart';

///
/// Cascader级联选择器
///

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Divider(
            height: 1,
            color: Color(0xffEFEFEF),
            thickness: 1,
          ),
          Container(
            height:38,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  YmTextButton("取消", Color(0xFF666666), (){
                    widget.onCancelClick();
                  },isOutlined: true,size: Size(60,30),borderColor: Color(0x00666666),),

                  YmTextButton("确定", Color(0xFF3446F2), (){
                    widget.onOkClick();
                  },isOutlined: true,size:Size(60,30),borderColor: Color(0x00666666),),
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