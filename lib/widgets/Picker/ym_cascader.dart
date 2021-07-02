import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_text_button.dart';
import 'package:ym_flutter_widget/widgets/Picker/ym_picker.dart';

/// 级联选择器（多级）
class YmCascader extends StatelessWidget {

  //数据
  final List<List<Map>> data;
  //默认值
  final List<String> value;

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
  Widget build(BuildContext context) {

    double pickerItemWidth = (MediaQuery.of(context).size.width)/this.data.length;
    List<YmPicker> pickerList = [];

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
                    this.onCancelClick();
                  },size: Size(80,40),backgroundColor: Colors.transparent,pressedBackgroundColor:Color(0xFFEFEFEF) ,),

                  YmTextButton("确定", textColor:Color(0xFF3446F2), onClick:(){
                    this.onOkClick();
                  },size:Size(80,40),backgroundColor: Colors.transparent,pressedBackgroundColor:Color(0xFFEFEFEF)),
                ]
            ),
          ),

          Row(
            children:List.generate(this.data.length, (position) {
              YmPicker picker = YmPicker(
                this.data[position],
                this.value[position],
                width: pickerItemWidth,
                itemHeight: 40,
                height: 180,
                onChanged: (index,val) {
                  print("Picker onChanged  position=" + position.toString() + ",index=" + index.toString() + ",val=" + val);
                  this.onChanged(position,index,val);
                },
              );
              pickerList.add(picker);
              return picker;
            }),
          )
        ],
      ),
    );
  }

}
